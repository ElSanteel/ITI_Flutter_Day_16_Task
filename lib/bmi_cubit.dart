import 'package:bloc/bloc.dart';

class BmiCubit extends Cubit<BmiState> {
  BmiCubit() : super(BmiEmpty());

  Future<void> calculateBMI(
      int age, String gender, int height, int weight) async {
    emit(BmiLoading());

    await Future.delayed(
        const Duration(seconds: 3)); // Simulate loading for 1 second

    if (height <= 0 || weight <= 0) {
      emit(BmiError("Invalid height or weight"));
      return;
    }

    double heightInMeter = height / 100.0;
    double bmi = weight / (heightInMeter * heightInMeter);

    emit(BmiCalculated(
        age: age, gender: gender, height: height, weight: weight, bmi: bmi));
  }

  String getBmiStatus(double bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return "Normal weight";
    } else if (bmi >= 25 && bmi < 29.9) {
      return "Overweight";
    } else if (bmi >= 30 && bmi < 34.9) {
      return "Obese";
    } else {
      return "Extremely Obese";
    }
  }
}

abstract class BmiState {}

class BmiEmpty extends BmiState {}

class BmiLoading extends BmiState {}

class BmiCalculated extends BmiState {
  final int age;
  final String gender;
  final int height;
  final int weight;
  final double bmi;

  BmiCalculated({
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.bmi,
  });
}

class BmiError extends BmiState {
  final String message;

  BmiError(this.message);
}
