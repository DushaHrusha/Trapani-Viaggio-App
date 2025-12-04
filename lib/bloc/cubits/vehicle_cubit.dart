import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/state/vehicle_state.dart';
import 'package:test_task/data/repositories/vehicle_repository.dart';

class VehicleCubit extends Cubit<VehicleState> {
  final VehicleRepository repository;

  VehicleCubit({required this.repository}) : super(VehicleInitial()) {
    loadVehicles();
  }

  /// Загрузить транспорт
  Future<void> loadVehicles() async {
    print('🎯 VehicleCubit: Starting to load ${repository.vehicleType}s');
    emit(VehicleLoading());

    try {
      final vehicles = await repository.getVehicles();
      print(
        '🎯 VehicleCubit: Loaded ${vehicles.length} ${repository.vehicleType}s',
      );
      print('🎯 VehicleCubit: Emitting VehicleLoaded state');
      emit(VehicleLoaded(vehicles));
      print('🎯 VehicleCubit: State emitted successfully');
    } catch (e) {
      print('🎯 VehicleCubit: Error loading ${repository.vehicleType}s: $e');
      emit(VehicleError(e.toString()));
    }
  }

  /// Обновить данные (Pull-to-refresh)
  Future<void> refreshVehicles() async {
    print('🎯 VehicleCubit: Refreshing ${repository.vehicleType}s');
    final currentState = state;

    try {
      final vehicles = await repository.refreshVehicles();
      print(
        '🎯 VehicleCubit: Refreshed ${vehicles.length} ${repository.vehicleType}s',
      );
      emit(VehicleLoaded(vehicles));
    } catch (e) {
      print('🎯 VehicleCubit: Refresh failed: $e');
      if (currentState is VehicleLoaded) {
        print('🎯 VehicleCubit: Keeping current data after refresh failure');
      } else {
        emit(VehicleError(e.toString()));
      }
    }
  }

  /// Очистить кэш
  Future<void> clearCache() async {
    await repository.clearCache();
    await loadVehicles();
  }

  /// Получить информацию о кэше
  Future<Map<String, dynamic>> getCacheInfo() async {
    return await repository.getCacheInfo();
  }
}
