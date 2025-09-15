import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/state/apartments_state.dart';
import 'package:test_task/data/models/apartment.dart';
import 'package:test_task/data/repositories/apartments_repository.dart';

class ApartmentCubit extends Cubit<ApartmentsState> {
  ApartmentCubit() : super(ApartmentsInitial()) {
    final ApartmentsRepository apartmentsRepository = ApartmentsRepository();
    List<Apartment> apartments = apartmentsRepository.apartments;
    emit(ApartmentsLoaded(apartments));
  }
}
