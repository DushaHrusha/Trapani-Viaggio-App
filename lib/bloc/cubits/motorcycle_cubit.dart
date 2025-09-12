import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/state/motorcycle_state.dart';
import 'package:test_task/data/repositories/motorcycle_repository.dart';

class MotorcycleCubit extends Cubit<MotorcycleState> {
  final MotorcycleRepository _repository = MotorcycleRepository();

  MotorcycleCubit() : super(MotorcycleInitial());

  void loadMotorcycles() {
    final motorcycles = _repository.fetchMotorcycles();
    emit(MotorcycleLoaded(motorcycles));
  }
}
