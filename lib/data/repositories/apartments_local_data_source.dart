// data/datasources/apartments_local_datasource.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_task/data/models/apartment.dart';

class ApartmentsLocalDataSource {
  static const String _boxName = 'apartments_cache';
  static const String _metadataBoxName = 'cache_metadata';
  static const Duration _cacheValidDuration = Duration(hours: 24);

  /// Получить бокс для квартир (сохраняем как Map)
  Future<Box<Map>> _getApartmentsBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<Map>(_boxName);
    }
    return Hive.box<Map>(_boxName);
  }

  /// Получить бокс для метаданных
  Future<Box> _getMetadataBox() async {
    if (!Hive.isBoxOpen(_metadataBoxName)) {
      return await Hive.openBox(_metadataBoxName);
    }
    return Hive.box(_metadataBoxName);
  }

  /// Сохранить список квартир в кэш
  Future<void> cacheApartments(List<Apartment> apartments) async {
    final box = await _getApartmentsBox();
    final metadataBox = await _getMetadataBox();

    // Добавляем timestamp к каждой квартире
    final apartmentsWithTimestamp =
        apartments.map((apt) {
          return apt.copyWith(cachedAt: DateTime.now());
        }).toList();

    // Очищаем старый кэш
    await box.clear();

    // Сохраняем квартиры как JSON
    for (var apartment in apartmentsWithTimestamp) {
      await box.put(apartment.id, apartment.toJson());
    }

    // Сохраняем время последнего обновления
    await metadataBox.put(
      'last_cache_update',
      DateTime.now().toIso8601String(),
    );

    print('💾 Cached ${apartments.length} apartments');
  }

  /// Сохранить одну квартиру в кэш
  Future<void> cacheApartment(Apartment apartment) async {
    final box = await _getApartmentsBox();
    final apartmentWithTimestamp = apartment.copyWith(cachedAt: DateTime.now());
    await box.put(apartment.id, apartmentWithTimestamp.toJson());
    print('💾 Cached apartment #${apartment.id}');
  }

  /// Получить все квартиры из кэша
  Future<List<Apartment>> getCachedApartments() async {
    final box = await _getApartmentsBox();
    final apartments =
        box.values
            .map((json) => Apartment.fromJson(Map<String, dynamic>.from(json)))
            .toList();
    print('📂 Retrieved ${apartments.length} apartments from cache');
    return apartments;
  }

  /// Получить квартиру по ID из кэша
  Future<Apartment?> getCachedApartmentById(int id) async {
    final box = await _getApartmentsBox();
    final json = box.get(id);
    if (json != null) {
      print('📂 Retrieved apartment #$id from cache');
      return Apartment.fromJson(Map<String, dynamic>.from(json));
    }
    return null;
  }

  /// Проверить, валиден ли кэш
  Future<bool> isCacheValid() async {
    try {
      final metadataBox = await _getMetadataBox();
      final box = await _getApartmentsBox();

      if (box.isEmpty) {
        print('❌ Cache is empty');
        return false;
      }

      final lastUpdateString = metadataBox.get('last_cache_update') as String?;
      if (lastUpdateString == null) {
        print('❌ No cache timestamp found');
        return false;
      }

      final lastUpdate = DateTime.parse(lastUpdateString);
      final difference = DateTime.now().difference(lastUpdate);
      final isValid = difference < _cacheValidDuration;

      if (isValid) {
        print(
          '✅ Cache is valid (age: ${difference.inHours}h ${difference.inMinutes % 60}m)',
        );
      } else {
        print('⏰ Cache expired (age: ${difference.inHours}h)');
      }

      return isValid;
    } catch (e) {
      print('❌ Error checking cache validity: $e');
      return false;
    }
  }

  /// Получить время последнего обновления кэша
  Future<DateTime?> getLastCacheUpdate() async {
    try {
      final metadataBox = await _getMetadataBox();
      final lastUpdateString = metadataBox.get('last_cache_update') as String?;
      if (lastUpdateString != null) {
        return DateTime.parse(lastUpdateString);
      }
    } catch (e) {
      print('❌ Error getting last cache update: $e');
    }
    return null;
  }

  /// Очистить кэш
  Future<void> clearCache() async {
    final box = await _getApartmentsBox();
    final metadataBox = await _getMetadataBox();
    await box.clear();
    await metadataBox.clear();
    print('🗑️ Cache cleared');
  }

  /// Получить размер кэша
  Future<int> getCacheSize() async {
    final box = await _getApartmentsBox();
    return box.length;
  }
}
