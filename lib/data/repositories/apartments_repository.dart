// data/repositories/apartments_repository.dart
import 'package:test_task/api_client.dart';
import 'package:test_task/api_endpoints.dart';
import 'package:test_task/data/models/apartment.dart';
import 'package:test_task/data/repositories/apartments_local_data_source.dart';
import 'package:test_task/data/repositories/connectivity_service.dart';

class ApartmentsRepository {
  final ApiClient _apiClient;
  final ApartmentsLocalDataSource _localDataSource;
  final ConnectivityService _connectivityService;

  ApartmentsRepository({
    required ApiClient apiClient,
    required ApartmentsLocalDataSource localDataSource,
    required ConnectivityService connectivityService,
  }) : _apiClient = apiClient,
       _localDataSource = localDataSource,
       _connectivityService = connectivityService;

  /// Получить все квартиры с умным кэшированием
  Future<List<Apartment>> getApartments({bool forceRefresh = false}) async {
    print('\n🔄 Loading apartments (forceRefresh: $forceRefresh)');

    try {
      // 1. Проверяем интернет-соединение
      final hasInternet = await _connectivityService.hasInternetConnection();

      // 2. Если нет интернета - возвращаем из кэша
      if (!hasInternet) {
        print('📱 Loading from cache (no internet)');
        final cachedApartments = await _localDataSource.getCachedApartments();

        if (cachedApartments.isEmpty) {
          throw NoInternetException(
            'Нет подключения к интернету и нет сохраненных данных',
          );
        }

        return cachedApartments;
      }

      // 3. Если есть интернет и не требуется принудительное обновление
      if (!forceRefresh) {
        final isCacheValid = await _localDataSource.isCacheValid();

        if (isCacheValid) {
          print('✅ Using valid cache');
          final cachedApartments = await _localDataSource.getCachedApartments();

          if (cachedApartments.isNotEmpty) {
            // Параллельно обновляем данные в фоне (опционально)
            _updateCacheInBackground();
            return cachedApartments;
          }
        }
      }

      // 4. Загружаем данные с сервера
      print('🌐 Fetching from server');
      final response = await _apiClient.get(ApiEndpoints.apartments);

      if (response.data['success'] == true) {
        // API возвращает данные в формате { items: [...], pagination: {...} }
        final responseData = response.data['data'];
        final List<dynamic> data;

        // Поддержка обоих форматов: с пагинацией и без
        if (responseData is List) {
          data = responseData;
        } else if (responseData is Map && responseData.containsKey('items')) {
          data = responseData['items'] as List;
        } else {
          throw ServerException('Неверный формат данных от сервера');
        }

        final apartments =
            data
                .map((json) => Apartment.fromJson(json as Map<String, dynamic>))
                .toList();

        // 5. Сохраняем в кэш
        await _localDataSource.cacheApartments(apartments);
        print(
          '✅ Data loaded and cached successfully (${apartments.length} items)',
        );

        return apartments;
      } else {
        throw ServerException('Не удалось загрузить квартиры');
      }
    } on ServerException catch (e) {
      print('⚠️ Server error: $e');
      // При ошибке сервера пытаемся вернуть кэш
      return await _getFallbackData();
    } catch (e) {
      print('❌ Unexpected error: $e');
      // При любой ошибке пытаемся вернуть кэш
      return await _getFallbackData();
    }
  }

  /// Получить квартиру по ID с кэшированием
  Future<Apartment> getApartmentById(int id) async {
    print('\n🔄 Loading apartment #$id');

    try {
      final hasInternet = await _connectivityService.hasInternetConnection();

      // Сначала пытаемся получить из кэша
      final cachedApartment = await _localDataSource.getCachedApartmentById(id);

      // Если нет интернета - возвращаем кэш
      if (!hasInternet) {
        if (cachedApartment != null) {
          print('📱 Returning cached apartment (no internet)');
          return cachedApartment;
        }
        throw NoInternetException('Нет подключения к интернету');
      }

      // Загружаем с сервера
      print('🌐 Fetching apartment from server');
      final response = await _apiClient.get(ApiEndpoints.apartmentById(id));

      if (response.data['success'] == true) {
        final apartment = Apartment.fromJson(
          response.data['data'] as Map<String, dynamic>,
        );

        // Сохраняем в кэш
        await _localDataSource.cacheApartment(apartment);
        print('✅ Apartment loaded and cached');

        return apartment;
      } else {
        throw ServerException('Квартира не найдена');
      }
    } catch (e) {
      print('⚠️ Error loading apartment: $e');

      // Пытаемся вернуть из кэша
      final cachedApartment = await _localDataSource.getCachedApartmentById(id);
      if (cachedApartment != null) {
        print('📱 Returning cached apartment (fallback)');
        return cachedApartment;
      }

      rethrow;
    }
  }

  /// Принудительно обновить данные
  Future<List<Apartment>> refreshApartments() async {
    print('\n🔄 Force refreshing apartments');
    return await getApartments(forceRefresh: true);
  }

  /// Очистить кэш
  Future<void> clearCache() async {
    await _localDataSource.clearCache();
  }

  /// Получить информацию о кэше
  Future<Map<String, dynamic>> getCacheInfo() async {
    final size = await _localDataSource.getCacheSize();
    final lastUpdate = await _localDataSource.getLastCacheUpdate();
    final isValid = await _localDataSource.isCacheValid();

    return {'size': size, 'lastUpdate': lastUpdate, 'isValid': isValid};
  }

  /// Fallback данные из кэша
  Future<List<Apartment>> _getFallbackData() async {
    print('🔄 Attempting to load fallback data from cache');
    final cachedApartments = await _localDataSource.getCachedApartments();

    if (cachedApartments.isEmpty) {
      throw CacheException('Нет доступных данных');
    }

    print('📱 Returning ${cachedApartments.length} apartments from cache');
    return cachedApartments;
  }

  /// Обновить кэш в фоне (не блокирует UI)
  void _updateCacheInBackground() {
    print('🔄 Updating cache in background');

    getApartments(forceRefresh: true)
        .then((apartments) {
          print('✅ Background cache update completed');
        })
        .catchError((error) {
          print('⚠️ Background cache update failed: $error');
        });
  }
}

// Кастомные исключения
class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  @override
  String toString() => message;
}

class NoInternetException implements Exception {
  final String message;
  NoInternetException(this.message);

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);

  @override
  String toString() => message;
}
