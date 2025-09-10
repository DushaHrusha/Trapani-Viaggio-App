import 'package:test_task/data/models/car.dart';

abstract class CarState {}

class CarInitial extends CarState {}

class CarLoaded extends CarState {
  // final int currentIndex;
  final List<Car> cars;

  //CarLoaded(this.currentIndex, this.cars);
  CarLoaded(this.cars);
}
