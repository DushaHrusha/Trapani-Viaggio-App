import 'package:test_task/data/models/motorcycle.dart';

abstract class MotorcycleState {}

class MotorcycleInitial extends MotorcycleState {}

class MotorcycleLoading extends MotorcycleState {}

class MotorcycleLoaded extends MotorcycleState {
  final List<Motorcycle> motorcycles;
  MotorcycleLoaded(this.motorcycles);
}
