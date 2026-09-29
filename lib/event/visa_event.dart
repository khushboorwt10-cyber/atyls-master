
import '../models/visa_model.dart';

abstract class VisaEvent {
  const VisaEvent();
}

class LoadVisaDetails extends VisaEvent {
  final VisaModel visa;

  const LoadVisaDetails(this.visa);
}

class StartVisaApplication extends VisaEvent {
  const StartVisaApplication();
}