import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/state/excursion_state.dart';
import 'package:test_task/data/repositories/excursions_repository.dart';

class ExcursionCubit extends Cubit<ExcursionState> {
  final ExcursionsRepository excursionsRepository;

  ExcursionCubit({required this.excursionsRepository})
    : super(ExcursionInitial()) {
    loadExcursions();
  }

  /// Загрузить экскурсии
  Future<void> loadExcursions() async {
    print('🎯 ExcursionCubit: Starting to load excursions');
    emit(ExcursionLoading());

    try {
      final excursions = await excursionsRepository.getExcursions();
      print('🎯 ExcursionCubit: Loaded ${excursions.length} excursions');
      print('🎯 ExcursionCubit: Emitting ExcursionLoaded state');
      emit(ExcursionLoaded(excursions));
      print('🎯 ExcursionCubit: State emitted successfully');
    } catch (e) {
      print('🎯 ExcursionCubit: Error loading excursions: $e');
      emit(ExcursionError(e.toString()));
    }
  }

  /// Обновить данные (Pull-to-refresh)
  Future<void> refreshExcursions() async {
    print('🎯 ExcursionCubit: Refreshing excursions');
    final currentState = state;

    try {
      final excursions = await excursionsRepository.refreshExcursions();
      print('🎯 ExcursionCubit: Refreshed ${excursions.length} excursions');
      emit(ExcursionLoaded(excursions));
    } catch (e) {
      print('🎯 ExcursionCubit: Refresh failed: $e');
      if (currentState is ExcursionLoaded) {
        print('🎯 ExcursionCubit: Keeping current data after refresh failure');
      } else {
        emit(ExcursionError(e.toString()));
      }
    }
  }

  /// Очистить кэш
  Future<void> clearCache() async {
    await excursionsRepository.clearCache();
    await loadExcursions();
  }

  /// Получить информацию о кэше
  Future<Map<String, dynamic>> getCacheInfo() async {
    return await excursionsRepository.getCacheInfo();
  }
}
