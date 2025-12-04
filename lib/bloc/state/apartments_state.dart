import 'package:test_task/data/models/apartment.dart';

abstract class ApartmentsState {}

class ApartmentsInitial extends ApartmentsState {}

class ApartmentsError extends ApartmentsState {
  ApartmentsError(String string);
}

class ApartmentsLoading extends ApartmentsState {}

class ApartmentsLoaded extends ApartmentsState {
  final List<Apartment> apartments;

  ApartmentsLoaded(this.apartments);
}
