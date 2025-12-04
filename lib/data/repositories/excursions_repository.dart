// data/repositories/excursions_repository.dart
import 'package:test_task/api_client.dart';
import 'package:test_task/api_endpoints.dart';
import 'package:test_task/data/models/excursion_model.dart';
import 'package:test_task/data/repositories/connectivity_service.dart';
import 'package:test_task/data/repositories/excursions_local_data_source.dart';

class ExcursionsRepository {
  final ApiClient _apiClient;
  final ExcursionsLocalDataSource _localDataSource;
  final ConnectivityService _connectivityService;

  ExcursionsRepository({
    required ApiClient apiClient,
    required ExcursionsLocalDataSource localDataSource,
    required ConnectivityService connectivityService,
  }) : _apiClient = apiClient,
       _localDataSource = localDataSource,
       _connectivityService = connectivityService;

  /// Получить все экскурсии с умным кэшированием
  Future<List<Excursion>> getExcursions({bool forceRefresh = false}) async {
    print('\n🔄 Loading excursions (forceRefresh: $forceRefresh)');

    try {
      // 1. Проверяем интернет-соединение
      final hasInternet = await _connectivityService.hasInternetConnection();

      // 2. Если нет интернета - возвращаем из кэша
      if (!hasInternet) {
        print('📱 Loading excursions from cache (no internet)');
        final cachedExcursions = await _localDataSource.getCachedExcursions();

        if (cachedExcursions.isEmpty) {
          throw NoInternetException(
            'Нет подключения к интернету и нет сохраненных данных',
          );
        }

        return cachedExcursions;
      }

      // 3. Если есть интернет и не требуется принудительное обновление
      if (!forceRefresh) {
        final isCacheValid = await _localDataSource.isCacheValid();

        if (isCacheValid) {
          print('✅ Using valid excursions cache');
          final cachedExcursions = await _localDataSource.getCachedExcursions();

          if (cachedExcursions.isNotEmpty) {
            // Параллельно обновляем данные в фоне (опционально)
            _updateCacheInBackground();
            return cachedExcursions;
          }
        }
      }

      // 4. Загружаем данные с сервера
      print('🌐 Fetching excursions from server');
      final response = await _apiClient.get(ApiEndpoints.excursions);

      if (response.data['success'] == true) {
        // ← ИСПРАВЛЕНО: извлекаем items из data
        final Map<String, dynamic> data =
            response.data['data'] as Map<String, dynamic>;
        final List<dynamic> items = data['items'] as List;

        final excursions =
            items
                .map((json) => Excursion.fromJson(json as Map<String, dynamic>))
                .toList();

        // 5. Сохраняем в кэш
        await _localDataSource.cacheExcursions(excursions);
        print('✅ Excursions loaded and cached successfully');

        return excursions;
      } else {
        throw ServerException('Не удалось загрузить экскурсии');
      }
    } on ServerException catch (e) {
      print('⚠️ Server error: $e');
      return await _getFallbackData();
    } catch (e) {
      print('❌ Unexpected error: $e');
      return await _getFallbackData();
    }
  }

  /// Получить экскурсию по ID с кэшированием
  Future<Excursion> getExcursionById(int id) async {
    print('\n🔄 Loading excursion #$id');

    try {
      final hasInternet = await _connectivityService.hasInternetConnection();

      // Сначала пытаемся получить из кэша
      final cachedExcursion = await _localDataSource.getCachedExcursionById(id);

      // Если нет интернета - возвращаем кэш
      if (!hasInternet) {
        if (cachedExcursion != null) {
          print('📱 Returning cached excursion (no internet)');
          return cachedExcursion;
        }
        throw NoInternetException('Нет подключения к интернету');
      }

      // Загружаем с сервера
      print('🌐 Fetching excursion from server');
      final response = await _apiClient.get(ApiEndpoints.excursionById(id));

      if (response.data['success'] == true) {
        // ← ИСПРАВЛЕНО: извлекаем data напрямую
        final Map<String, dynamic> excursionData =
            response.data['data'] as Map<String, dynamic>;
        final excursion = Excursion.fromJson(excursionData);

        // Сохраняем в кэш
        await _localDataSource.cacheExcursion(excursion);
        print('✅ Excursion loaded and cached');

        return excursion;
      } else {
        throw ServerException('Экскурсия не найдена');
      }
    } catch (e) {
      print('⚠️ Error loading excursion: $e');

      // Пытаемся вернуть из кэша
      final cachedExcursion = await _localDataSource.getCachedExcursionById(id);
      if (cachedExcursion != null) {
        print('📱 Returning cached excursion (fallback)');
        return cachedExcursion;
      }

      rethrow;
    }
  }

  /// Принудительно обновить данные
  Future<List<Excursion>> refreshExcursions() async {
    print('\n🔄 Force refreshing excursions');
    return await getExcursions(forceRefresh: true);
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
  Future<List<Excursion>> _getFallbackData() async {
    print('🔄 Attempting to load fallback excursions from cache');
    final cachedExcursions = await _localDataSource.getCachedExcursions();

    if (cachedExcursions.isEmpty) {
      throw CacheException('Нет доступных данных');
    }

    print('📱 Returning ${cachedExcursions.length} excursions from cache');
    return cachedExcursions;
  }

  /// Обновить кэш в фоне (не блокирует UI)
  void _updateCacheInBackground() {
    print('🔄 Updating excursions cache in background');

    getExcursions(forceRefresh: true)
        .then((excursions) {
          print('✅ Background excursions cache update completed');
        })
        .catchError((error) {
          print('⚠️ Background excursions cache update failed: $error');
        });
  }
}

// Кастомные исключения (если еще не определены)
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
