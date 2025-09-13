import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/state/vehicle_state.dart';
import 'package:test_task/data/repositories/vehicle_repository.dart';

class VehicleCubit extends Cubit<VehicleState> {
  VehicleCubit() : super(VehicleInitial());

  void loadExcursions(VehicleRepository repository) {
    var car = repository.vehicles;
    emit(VehicleLoaded(car));
  }
}
