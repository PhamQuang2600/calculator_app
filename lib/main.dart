import 'package:calculator_app/bloc/calculator_cubit.dart';
import 'package:calculator_app/screen/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const AppCalculator());
}

class AppCalculator extends StatelessWidget {
  const AppCalculator({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
          create: (context) => CalculatorCubit(),
          child: const MyApp()),
    );
  }
}

