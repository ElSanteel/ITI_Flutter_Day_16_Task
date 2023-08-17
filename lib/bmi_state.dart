part of 'bmi_cubit.dart';

abstract class BmiState {}

class BmiInitial extends BmiState {}

class BmiCalculated extends BmiState {
  final double bmi;

  BmiCalculated(this.bmi);
}

class BmiError extends BmiState {
  final String message;

  BmiError(this.message);
}
