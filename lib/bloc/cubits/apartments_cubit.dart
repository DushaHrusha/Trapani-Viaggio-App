import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/state/apartments_state.dart';
import 'package:test_task/data/models/apartment.dart';
import 'package:test_task/data/repositories/apartments_repository.dart';

class ApartmentsCubit extends Cubit<ApartmentsState> {
  ApartmentsCubit() : super(ApartmentsInitial());
  final ApartmentsRepository _apartmentsRepository = ApartmentsRepository();

  void loadExcursions() {
    List<Apartment> apartments = _apartmentsRepository.apartments;
    emit(ApartmentsLoaded(apartments));
  }
}
