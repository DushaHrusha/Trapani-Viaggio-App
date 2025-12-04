// bloc/cubits/apartments_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/state/apartments_state.dart';
import 'package:test_task/data/repositories/apartments_repository.dart';

class ApartmentCubit extends Cubit<ApartmentsState> {
  final ApartmentsRepository apartmentsRepository;

  ApartmentCubit({required this.apartmentsRepository})
    : super(ApartmentsInitial()) {
    loadApartments();
  }

  /// Загрузить квартиры
  Future<void> loadApartments({bool forceRefresh = false}) async {
    print(
      '🏠 ApartmentCubit: loadApartments started (forceRefresh: $forceRefresh)',
    );
    emit(ApartmentsLoading());

    try {
      final apartments = await apartmentsRepository.getApartments(
        forceRefresh: forceRefresh,
      );

      print('🏠 ApartmentCubit: Loaded ${apartments.length} apartments');
      print(
        '🏠 ApartmentCubit: First apartment: ${apartments.isNotEmpty ? apartments.first.title : "none"}',
      );

      emit(ApartmentsLoaded(apartments));
    } catch (e, stackTrace) {
      print('🏠 ApartmentCubit: Error loading apartments: $e');
      print('🏠 StackTrace: $stackTrace');
      emit(ApartmentsError(e.toString()));
    }
  }

  /// Обновить данные (Pull-to-refresh)
  Future<void> refreshApartments() async {
    print('🏠 ApartmentCubit: refreshApartments started');

    // Не показываем loading при refresh, если уже есть данные
    final currentState = state;

    try {
      final apartments = await apartmentsRepository.refreshApartments();
      print('🏠 ApartmentCubit: Refreshed ${apartments.length} apartments');
      emit(ApartmentsLoaded(apartments));
    } catch (e) {
      print('🏠 ApartmentCubit: Refresh error: $e');
      // Если ошибка при refresh и есть текущие данные - оставляем их
      if (currentState is ApartmentsLoaded) {
        print(
          '🏠 Refresh failed, keeping current ${currentState.apartments.length} apartments',
        );
      } else {
        emit(ApartmentsError(e.toString()));
      }
    }
  }

  /// Принудительно обновить с сервера (игнорирует кэш)
  Future<void> forceLoadFromServer() async {
    print('🏠 ApartmentCubit: forceLoadFromServer started');
    await loadApartments(forceRefresh: true);
  }

  /// Очистить кэш и перезагрузить
  Future<void> clearCacheAndReload() async {
    print('🏠 ApartmentCubit: Clearing cache...');
    await apartmentsRepository.clearCache();
    print('🏠 ApartmentCubit: Cache cleared, reloading...');
    await loadApartments(forceRefresh: true);
  }

  /// Очистить кэш
  Future<void> clearCache() async {
    await apartmentsRepository.clearCache();
    await loadApartments(forceRefresh: true);
  }

  /// Получить информацию о кэше
  Future<Map<String, dynamic>> getCacheInfo() async {
    return await apartmentsRepository.getCacheInfo();
  }
}
