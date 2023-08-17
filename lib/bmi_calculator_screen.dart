import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bmi_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final BmiCubit _bmiCubit = BmiCubit();
  String _selectedGender = "Male";
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff9f9f9).withOpacity(0.9),
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.bmi_calcultor),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.bmi_calcultor,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff484a55),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  width: 320,
                  height: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.age,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        TextField(
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 320,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: "Male",
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value.toString();
                            });
                          },
                        ),
                        Text(
                          AppLocalizations.of(context)!.male,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Spacer(),
                        Radio(
                          value: "Female",
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value.toString();
                            });
                          },
                        ),
                        Text(
                          AppLocalizations.of(context)!.female,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Container(
                        width: 140,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(children: [
                          const SizedBox(height: 10),
                          Text(
                            AppLocalizations.of(context)!.height,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          TextField(
                            controller: _heightController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                          ),
                        ]),
                      ),
                      const SizedBox(width: 25),
                      Container(
                        width: 160,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(children: [
                          const SizedBox(height: 10),
                          Text(
                            AppLocalizations.of(context)!.weight,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          TextField(
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: 320,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xff628bfd),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: BlocBuilder<BmiCubit, BmiState>(
                    bloc: _bmiCubit,
                    builder: (context, state) {
                      if (state is BmiLoading) {
                        return const CircularProgressIndicator();
                      } else {
                        return TextButton(
                          onPressed: () {
                            // Calculate BMI
                            int age = int.tryParse(_ageController.text) ?? 0;
                            int height =
                                int.tryParse(_heightController.text) ?? 0;
                            int weight =
                                int.tryParse(_weightController.text) ?? 0;

                            _bmiCubit.calculateBMI(
                              age,
                              _selectedGender,
                              height,
                              weight,
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.calculate,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.you_bmi_is,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xffb6b7b7).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: BlocBuilder<BmiCubit, BmiState>(
                      bloc: _bmiCubit,
                      builder: (context, state) {
                        if (state is BmiCalculated) {
                          String bmiResult = state.bmi.toStringAsFixed(1);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                bmiResult,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          );
                        } else if (state is BmiError) {
                          return Text(
                            'Error: ${state.message}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          );
                        } else {
                          return Text(AppLocalizations.of(context)!.empty,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold));
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 500,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xfff9f9f9).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: BlocBuilder<BmiCubit, BmiState>(
                      bloc: _bmiCubit,
                      builder: (context, state) {
                        if (state is BmiCalculated) {
                          String bmiResult = state.bmi.toStringAsFixed(1);
                          String status =
                              _bmiCubit.getBmiStatus(double.parse(bmiResult));
                          return Text(
                            'You are $status',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          );
                        } else if (state is BmiError) {
                          return Text(
                            'Error: ${state.message}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          );
                        } else {
                          return Text(AppLocalizations.of(context)!.empty,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold));
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
