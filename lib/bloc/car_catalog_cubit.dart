// 1. Создаем модель данных
import 'package:flutter_bloc/flutter_bloc.dart';

class Car {
  final String image;
  final String model;
  final int year;
  final double price;
  final String speed;

  Car({
    required this.image,
    required this.model,
    required this.year,
    required this.price,
    required this.speed,
  });
}

// 2. Создаем состояния
abstract class CarState {}

class CarInitial extends CarState {}

class CarLoaded extends CarState {
  final int currentIndex;
  final List<Car> cars;

  CarLoaded(this.currentIndex, this.cars);
}

// 3. Создаем Cubit
class CarCubit extends Cubit<CarState> {
  final List<Car> _cars = [
    Car(
      image: 'assets/alfaromeo.png',
      model: 'Fiat 500',
      year: 2015,
      price: 49,
      speed: '140 km/h',
    ),
    Car(
      image: 'assets/8cae23b507d3b49fef71ee10302db75cec9c27ce.png',
      model: 'Alfa Rome Giulietta',
      year: 2017,
      price: 54,
      speed: '230 km/h',
    ),
    // Добавьте другие автомобили
  ];

  CarCubit() : super(CarInitial()) {
    emit(CarLoaded(0, _cars));
  }

  void nextCar() {
    final state = this.state as CarLoaded;
    if (state.currentIndex < _cars.length - 1) {
      emit(CarLoaded(state.currentIndex + 1, _cars));
    }
  }

  void previousCar() {
    final state = this.state as CarLoaded;
    if (state.currentIndex > 0) {
      emit(CarLoaded(state.currentIndex - 1, _cars));
    }
  }
}
