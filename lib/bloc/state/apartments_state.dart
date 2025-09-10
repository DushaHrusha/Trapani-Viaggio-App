import 'package:flutter/material.dart';
import 'package:test_task/data/models/apartment.dart';

@immutable
abstract class ApartmentsState {}

class ApartmentsInitial extends ApartmentsState {}

class ApartmentsLoaded extends ApartmentsState {
  final List<Apartment> apartments;

  ApartmentsLoaded(this.apartments);
}
