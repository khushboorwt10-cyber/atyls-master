
import '../models/visa_model.dart';

abstract class VisaState {
  const VisaState();
}

class VisaInitial extends VisaState {
  const VisaInitial();
}

class VisaLoading extends VisaState {
  const VisaLoading();
}

class VisaLoaded extends VisaState {
  final VisaModel visa;

  const VisaLoaded(this.visa);
}

class VisaApplicationStarted extends VisaState {
  final VisaModel visa;

  const VisaApplicationStarted(this.visa);
}

class VisaError extends VisaState {
  final String message;

  const VisaError(this.message);
}