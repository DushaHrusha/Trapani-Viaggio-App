import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/excursion.dart';
import 'package:test_task/excursion_state.dart';
import 'package:test_task/excursions_repository.dart';

class ExcursionCubit extends Cubit<ExcursionState> {
  ExcursionCubit() : super(ExcursionInitial());
  final ExcursionsRepository _excursionsRepository = ExcursionsRepository();

  void loadExcursions() {
    List<Excursion> excursions = _excursionsRepository.excursions;
    emit(ExcursionLoaded(excursions));
  }
}
