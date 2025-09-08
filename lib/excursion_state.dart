import 'package:flutter/material.dart';
import 'package:test_task/excursion.dart';

@immutable
abstract class ExcursionState {}

class ExcursionInitial extends ExcursionState {}

class ExcursionLoaded extends ExcursionState {
  final List<Excursion> excursions;

  ExcursionLoaded(this.excursions);
}
