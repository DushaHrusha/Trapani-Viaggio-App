// data/datasources/vehicles_local_datasource.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_task/data/models/vehicle.dart';

class VehiclesLocalDataSource {
  static const String _carsBoxName = 'cars_cache';
  static const String _motorcyclesBoxName = 'motorcycles_cache';
  static const String _vespasBoxName = 'vespas_cache';
  static const String _metadataBoxName = 'vehicles_cache_metadata';
  static const Duration _cacheValidDuration = Duration(hours: 24);

  /// Получить бокс для конкретного типа транспорта
  Future<Box<Map>> _getVehicleBox(String vehicleType) async {
    String boxName;
    switch (vehicleType.toLowerCase()) {
      case 'car':
        boxName = _carsBoxName;
        break;
      case 'motorcycle':
        boxName = _motorcyclesBoxName;
        break;
      case 'vespa':
        boxName = _vespasBoxName;
        break;
      default:
        throw Exception('Unknown vehicle type: $vehicleType');
    }

    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<Map>(boxName);
    }
    return Hive.box<Map>(boxName);
  }

  /// Получить бокс для метаданных
  Future<Box> _getMetadataBox() async {
    if (!Hive.isBoxOpen(_metadataBoxName)) {
      return await Hive.openBox(_metadataBoxName);
    }
    return Hive.box(_metadataBoxName);
  }

  /// Сохранить список транспорта в кэш
  Future<void> cacheVehicles(List<Vehicle> vehicles, String vehicleType) async {
    if (vehicles.isEmpty) return;

    final box = await _getVehicleBox(vehicleType);
    final metadataBox = await _getMetadataBox();

    // Добавляем timestamp
    final vehiclesWithTimestamp =
        vehicles.map((vehicle) {
          return vehicle.copyWith(cachedAt: DateTime.now());
        }).toList();

    // Очищаем старый кэш
    await box.clear();

    // Сохраняем транспорт как JSON
    for (var vehicle in vehiclesWithTimestamp) {
      await box.put(vehicle.id, vehicle.toJson());
    }

    // Сохраняем время последнего обновления
    await metadataBox.put(
      'last_cache_update_$vehicleType',
      DateTime.now().toIso8601String(),
    );

    print('💾 Cached ${vehicles.length} ${vehicleType}s');
  }

  /// Сохранить один транспорт в кэш
  Future<void> cacheVehicle(Vehicle vehicle) async {
    final box = await _getVehicleBox(vehicle.type);
    final vehicleWithTimestamp = vehicle.copyWith(cachedAt: DateTime.now());
    await box.put(vehicle.id, vehicleWithTimestamp.toJson());
    print('💾 Cached ${vehicle.type} #${vehicle.id}');
  }

  /// Получить весь транспорт из кэша
  Future<List<Vehicle>> getCachedVehicles(String vehicleType) async {
    final box = await _getVehicleBox(vehicleType);
    final vehicles =
        box.values
            .map((json) => Vehicle.fromJson(Map<String, dynamic>.from(json)))
            .toList();
    print('📂 Retrieved ${vehicles.length} ${vehicleType}s from cache');
    return vehicles;
  }

  /// Получить транспорт по ID из кэша
  Future<Vehicle?> getCachedVehicleById(int id, String vehicleType) async {
    final box = await _getVehicleBox(vehicleType);
    final json = box.get(id);
    if (json != null) {
      print('📂 Retrieved $vehicleType #$id from cache');
      return Vehicle.fromJson(Map<String, dynamic>.from(json));
    }
    return null;
  }

  /// Проверить, валиден ли кэш
  Future<bool> isCacheValid(String vehicleType) async {
    try {
      final metadataBox = await _getMetadataBox();
      final box = await _getVehicleBox(vehicleType);

      if (box.isEmpty) {
        print('❌ ${vehicleType}s cache is empty');
        return false;
      }

      final lastUpdateString =
          metadataBox.get('last_cache_update_$vehicleType') as String?;
      if (lastUpdateString == null) {
        print('❌ No ${vehicleType}s cache timestamp found');
        return false;
      }

      final lastUpdate = DateTime.parse(lastUpdateString);
      final difference = DateTime.now().difference(lastUpdate);
      final isValid = difference < _cacheValidDuration;

      if (isValid) {
        print(
          '✅ ${vehicleType}s cache is valid (age: ${difference.inHours}h ${difference.inMinutes % 60}m)',
        );
      } else {
        print('⏰ ${vehicleType}s cache expired (age: ${difference.inHours}h)');
      }

      return isValid;
    } catch (e) {
      print('❌ Error checking ${vehicleType}s cache validity: $e');
      return false;
    }
  }

  /// Получить время последнего обновления кэша
  Future<DateTime?> getLastCacheUpdate(String vehicleType) async {
    try {
      final metadataBox = await _getMetadataBox();
      final lastUpdateString =
          metadataBox.get('last_cache_update_$vehicleType') as String?;
      if (lastUpdateString != null) {
        return DateTime.parse(lastUpdateString);
      }
    } catch (e) {
      print('❌ Error getting last ${vehicleType}s cache update: $e');
    }
    return null;
  }

  /// Очистить кэш
  Future<void> clearCache(String vehicleType) async {
    final box = await _getVehicleBox(vehicleType);
    final metadataBox = await _getMetadataBox();
    await box.clear();
    await metadataBox.delete('last_cache_update_$vehicleType');
    print('🗑️ ${vehicleType}s cache cleared');
  }

  /// Очистить весь кэш транспорта
  Future<void> clearAllVehiclesCache() async {
    await clearCache('car');
    await clearCache('motorcycle');
    await clearCache('vespa');
    print('🗑️ All vehicles cache cleared');
  }

  /// Получить размер кэша
  Future<int> getCacheSize(String vehicleType) async {
    final box = await _getVehicleBox(vehicleType);
    return box.length;
  }
}
