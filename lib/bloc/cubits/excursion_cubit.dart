import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/data/models/excursion_model.dart';
import 'package:test_task/bloc/state/excursion_state.dart';
import 'package:test_task/data/repositories/excursions_repository.dart';

class ExcursionCubit extends Cubit<ExcursionState> {
  ExcursionCubit() : super(ExcursionInitial()) {
    final ExcursionsRepository _excursionsRepository = ExcursionsRepository();
    List<Excursion> excursions = _excursionsRepository.excursions;
    emit(ExcursionLoaded(excursions));
  }
}
