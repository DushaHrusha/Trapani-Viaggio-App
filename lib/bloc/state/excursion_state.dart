import 'package:test_task/data/models/excursion_model.dart';

abstract class ExcursionState {}

class ExcursionInitial extends ExcursionState {}

class ExcursionLoading extends ExcursionState {}

class ExcursionError extends ExcursionState {
  ExcursionError(String string);
}

class ExcursionLoaded extends ExcursionState {
  final List<Excursion> excursions;

  ExcursionLoaded(this.excursions);
}
