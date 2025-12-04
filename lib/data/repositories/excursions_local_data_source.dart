import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_task/data/models/excursion_model.dart';

class ExcursionsLocalDataSource {
  static const String _boxName = 'excursions_cache';
  static const String _metadataBoxName = 'excursions_cache_metadata';
  static const Duration _cacheValidDuration = Duration(hours: 24);

  /// Получить бокс для экскурсий (сохраняем как Map)
  Future<Box<Map>> _getExcursionsBox() async {
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

  /// Сохранить список экскурсий в кэш
  Future<void> cacheExcursions(List<Excursion> excursions) async {
    final box = await _getExcursionsBox();
    final metadataBox = await _getMetadataBox();

    // Добавляем timestamp к каждой экскурсии
    final excursionsWithTimestamp =
        excursions.map((exc) {
          return exc.copyWith(cachedAt: DateTime.now());
        }).toList();

    // Очищаем старый кэш
    await box.clear();

    // Сохраняем экскурсии как JSON
    for (var excursion in excursionsWithTimestamp) {
      await box.put(excursion.id, excursion.toJson());
    }

    // Сохраняем время последнего обновления
    await metadataBox.put(
      'last_cache_update',
      DateTime.now().toIso8601String(),
    );

    print('💾 Cached ${excursions.length} excursions');
  }

  /// Сохранить одну экскурсию в кэш
  Future<void> cacheExcursion(Excursion excursion) async {
    final box = await _getExcursionsBox();
    final excursionWithTimestamp = excursion.copyWith(cachedAt: DateTime.now());
    await box.put(excursion.id, excursionWithTimestamp.toJson());
    print('💾 Cached excursion #${excursion.id}');
  }

  /// Получить все экскурсии из кэша
  Future<List<Excursion>> getCachedExcursions() async {
    final box = await _getExcursionsBox();
    final excursions =
        box.values
            .map((json) => Excursion.fromJson(Map<String, dynamic>.from(json)))
            .toList();
    print('📂 Retrieved ${excursions.length} excursions from cache');
    return excursions;
  }

  /// Получить экскурсию по ID из кэша
  Future<Excursion?> getCachedExcursionById(int id) async {
    final box = await _getExcursionsBox();
    final json = box.get(id);
    if (json != null) {
      print('📂 Retrieved excursion #$id from cache');
      return Excursion.fromJson(Map<String, dynamic>.from(json));
    }
    return null;
  }

  /// Проверить, валиден ли кэш
  Future<bool> isCacheValid() async {
    try {
      final metadataBox = await _getMetadataBox();
      final box = await _getExcursionsBox();

      if (box.isEmpty) {
        print('❌ Excursions cache is empty');
        return false;
      }

      final lastUpdateString = metadataBox.get('last_cache_update') as String?;
      if (lastUpdateString == null) {
        print('❌ No excursions cache timestamp found');
        return false;
      }

      final lastUpdate = DateTime.parse(lastUpdateString);
      final difference = DateTime.now().difference(lastUpdate);
      final isValid = difference < _cacheValidDuration;

      if (isValid) {
        print(
          '✅ Excursions cache is valid (age: ${difference.inHours}h ${difference.inMinutes % 60}m)',
        );
      } else {
        print('⏰ Excursions cache expired (age: ${difference.inHours}h)');
      }

      return isValid;
    } catch (e) {
      print('❌ Error checking excursions cache validity: $e');
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
      print('❌ Error getting last excursions cache update: $e');
    }
    return null;
  }

  /// Очистить кэш
  Future<void> clearCache() async {
    final box = await _getExcursionsBox();
    final metadataBox = await _getMetadataBox();
    await box.clear();
    await metadataBox.clear();
    print('🗑️ Excursions cache cleared');
  }

  /// Получить размер кэша
  Future<int> getCacheSize() async {
    final box = await _getExcursionsBox();
    return box.length;
  }
}
