import 'package:flutter/material.dart';
import 'package:test_task/data/models/excursion_model.dart';

@immutable
abstract class ExcursionState {}

class ExcursionInitial extends ExcursionState {}

class ExcursionLoaded extends ExcursionState {
  final List<Excursion> excursions;

  ExcursionLoaded(this.excursions);
}
