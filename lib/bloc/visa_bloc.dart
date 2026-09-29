import 'package:flutter_bloc/flutter_bloc.dart';

import '../event/visa_event.dart';
import '../state/visa_state.dart';


class VisaBloc extends Bloc<VisaEvent, VisaState> {
  VisaBloc() : super(const VisaInitial()) {
    on<LoadVisaDetails>(_loadVisaDetails);
    on<StartVisaApplication>(_startApplication);
  }

  Future<void> _loadVisaDetails(
      LoadVisaDetails event,
      Emitter<VisaState> emit,
      ) async {
    emit(const VisaLoading());

    await Future.delayed(
      const Duration(milliseconds: 400),
    );

    emit(VisaLoaded(event.visa));
  }

  void _startApplication(
      StartVisaApplication event,
      Emitter<VisaState> emit,
      ) {
    if (state is VisaLoaded) {
      final currentVisa = (state as VisaLoaded).visa;

      emit(VisaApplicationStarted(currentVisa));
    }
  }
}