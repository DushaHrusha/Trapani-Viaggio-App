import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/state/car_state.dart';
import 'package:test_task/data/repositories/cars_repository.dart';

class CarCubit extends Cubit<CarState> {
  final CarsRepository carsRepository = CarsRepository();

  CarCubit() : super(CarInitial());

  void loadExcursions() {
    var car = carsRepository.cars;
    emit(CarLoaded(car));
  }

  // void nextCar() {
  //   final state = this.state as CarLoaded;
  //   if (state.currentIndex < carsRepository.cars.length - 1) {
  //     emit(CarLoaded(state.currentIndex + 1, carsRepository.cars));
  //   }
  // }

  // void previousCar() {
  //   final state = this.state as CarLoaded;
  //   if (state.currentIndex > 0) {
  //     emit(CarLoaded(state.currentIndex - 1, carsRepository.cars));
  //   }
  // }
}
