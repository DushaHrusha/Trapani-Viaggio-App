import 'package:test_task/api_client.dart';
import 'package:test_task/data/models/vehicle.dart';
import 'package:test_task/data/repositories/connectivity_service.dart';
import 'package:test_task/data/repositories/vehicles_local_datasource.dart';

abstract class VehicleRepository {
  final ApiClient apiClient;
  final VehiclesLocalDataSource localDataSource;
  final ConnectivityService connectivityService;

  VehicleRepository({
    required this.apiClient,
    required this.localDataSource,
    required this.connectivityService,
  });

  /// Тип транспорта (car, motorcycle, vespa)
  String get vehicleType;

  /// Получить транспорт с умным кэшированием
  Future<List<Vehicle>> getVehicles({bool forceRefresh = false}) async {
    print('\n🔄 Loading ${vehicleType}s (forceRefresh: $forceRefresh)');

    try {
      // 1. Проверяем интернет
      final hasInternet = await connectivityService.hasInternetConnection();

      // 2. Если нет интернета - возвращаем из кэша
      if (!hasInternet) {
        print('📱 Loading ${vehicleType}s from cache (no internet)');
        final cachedVehicles = await localDataSource.getCachedVehicles(
          vehicleType,
        );

        if (cachedVehicles.isEmpty) {
          throw NoInternetException(
            'Нет подключения к интернету и нет сохраненных данных',
          );
        }

        return cachedVehicles;
      }

      // 3. Загружаем с сервера (всегда если есть интернет)
      print('🌐 Fetching ${vehicleType}s from server');
      final vehicles = await fetchFromServer();

      // 4. Сохраняем в кэш
      await localDataSource.cacheVehicles(vehicles, vehicleType);
      print(
        '✅ ${vehicleType}s loaded and cached successfully (${vehicles.length} items)',
      );

      return vehicles;
    } on ServerException catch (e) {
      print('⚠️ Server error: $e');
      return await _getFallbackData();
    } catch (e) {
      print('❌ Unexpected error: $e');
      return await _getFallbackData();
    }
  }

  /// Получить транспорт по ID
  Future<Vehicle> getVehicleById(int id) async {
    print('\n🔄 Loading $vehicleType #$id');

    try {
      final hasInternet = await connectivityService.hasInternetConnection();

      // Сначала пытаемся получить из кэша
      final cachedVehicle = await localDataSource.getCachedVehicleById(
        id,
        vehicleType,
      );

      // Если нет интернета - возвращаем кэш
      if (!hasInternet) {
        if (cachedVehicle != null) {
          print('📱 Returning cached $vehicleType (no internet)');
          return cachedVehicle;
        }
        throw NoInternetException('Нет подключения к интернету');
      }

      // Загружаем с сервера
      print('🌐 Fetching $vehicleType from server');
      final vehicle = await fetchByIdFromServer(id);

      // Сохраняем в кэш
      await localDataSource.cacheVehicle(vehicle);
      print('✅ $vehicleType loaded and cached');

      return vehicle;
    } catch (e) {
      print('⚠️ Error loading $vehicleType: $e');

      // Пытаемся вернуть из кэша
      final cachedVehicle = await localDataSource.getCachedVehicleById(
        id,
        vehicleType,
      );
      if (cachedVehicle != null) {
        print('📱 Returning cached $vehicleType (fallback)');
        return cachedVehicle;
      }

      rethrow;
    }
  }

  /// Принудительно обновить данные
  Future<List<Vehicle>> refreshVehicles() async {
    print('\n🔄 Force refreshing ${vehicleType}s');
    return await getVehicles(forceRefresh: true);
  }

  /// Очистить кэш
  Future<void> clearCache() async {
    await localDataSource.clearCache(vehicleType);
  }

  /// Получить информацию о кэше
  Future<Map<String, dynamic>> getCacheInfo() async {
    final size = await localDataSource.getCacheSize(vehicleType);
    final lastUpdate = await localDataSource.getLastCacheUpdate(vehicleType);
    final isValid = await localDataSource.isCacheValid(vehicleType);

    return {'size': size, 'lastUpdate': lastUpdate, 'isValid': isValid};
  }

  /// Fallback данные из кэша
  Future<List<Vehicle>> _getFallbackData() async {
    print('🔄 Attempting to load fallback ${vehicleType}s from cache');
    final cachedVehicles = await localDataSource.getCachedVehicles(vehicleType);

    if (cachedVehicles.isEmpty) {
      throw CacheException('Нет доступных данных');
    }

    print('📱 Returning ${cachedVehicles.length} ${vehicleType}s from cache');
    return cachedVehicles;
  }

  /// Загрузить с сервера (реализуется в подклассах)
  Future<List<Vehicle>> fetchFromServer();

  /// Загрузить по ID с сервера (реализуется в подклассах)
  Future<Vehicle> fetchByIdFromServer(int id);
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
