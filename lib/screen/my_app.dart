import 'package:calculator_app/bloc/calculator_cubit.dart';
import 'package:calculator_app/widgets/widget_cal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late CalculatorCubit cubit;
  @override
  void initState() {
    cubit = context.read<CalculatorCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String formatWithCommas(String input) {
      var number = input.split('.');
      number[0] = number[0].replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");
      return number.join('.');
    }
    return Scaffold(body: Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          BlocBuilder(
            bloc: cubit,
            buildWhen: (p, c) => c is CalculatorLoaded,
            builder:(context, state) {
              if(state is CalculatorLoaded){
                return Flexible(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          cubit.numberOne.isEmpty && cubit.isEqual?const SizedBox(): Text(cubit.numberOne.isEmpty?'0':formatWithCommas(cubit.numberOne.join('')), style: const TextStyle(fontSize: 28, color: Colors.black)),
                          cubit.calculation.isEmpty?const SizedBox(): Text(' ${cubit.calculation.last} ', style: const TextStyle(fontSize: 28, color: Colors.black)),
                          cubit.calculation.isEmpty?const SizedBox(): Text(formatWithCommas(cubit.numberTwo.join('')), style: const TextStyle(fontSize: 28, color: Colors.black)),
                          cubit.isEqual? Text('= ${formatWithCommas(cubit.equalCalculator.toString())}', style: const TextStyle(fontSize: 28, color: Colors.black)):const SizedBox(),
                        ],
                      ),
                    ));
              }else{
               return Flexible(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      alignment: Alignment.bottomRight,
                      child: const Text('0', style: TextStyle(fontSize: 28, color: Colors.black)),
                    ));
              }
            },
          ),
          Flexible(
            flex: 4,
            child: LayoutBuilder(
            builder:(context, constraints) => Column(
              children: [
                Row(
                  children: [
                    WidgetCalculator.calculation(context, 'C',constraints.maxHeight, () {
                      cubit.clean();
                    },isFirst: true),
                    WidgetCalculator.calculation(context, '%',constraints.maxHeight,() {
                      cubit.percentCal();
                    }),
                    WidgetCalculator.calculation(context, 'assets/icons/remove.png',constraints.maxHeight,() {
                      cubit.remove();
                    }, isIcon: true),
                    WidgetCalculator.calculation(context, '+',constraints.maxHeight, () {
                      cubit.addCalculation('+');
                      cubit.continueCalculation();
                    }),
                  ],
                ),
                Row(
                  children: [
                    WidgetCalculator.numberEnter(context, '1',constraints.maxHeight, () {
                      cubit.inputNumber('1');
                    }, isFirst: true),
                    WidgetCalculator.numberEnter(context, '2',constraints.maxHeight, () {
                      cubit.inputNumber('2');
                    }),
                    WidgetCalculator.numberEnter(context, '3',constraints.maxHeight, () {
                      cubit.inputNumber('3');
                    }),
                    WidgetCalculator.calculation(context, '-',constraints.maxHeight, () {
                      cubit.addCalculation('-');
                      cubit.continueCalculation();
                    }),
                  ],
                ),
                Row(
                  children: [
                    WidgetCalculator.numberEnter(context, '4',constraints.maxHeight, () {
                      cubit.inputNumber('4');
                    }, isFirst: true),
                    WidgetCalculator.numberEnter(context, '5',constraints.maxHeight, () {
                      cubit.inputNumber('5');
                    }),
                    WidgetCalculator.numberEnter(context, '6',constraints.maxHeight, () {
                      cubit.inputNumber('6');
                    }),
                    WidgetCalculator.calculation(context, 'assets/icons/multiply.png',constraints.maxHeight, () {
                      cubit.addCalculation("*");
                      cubit.continueCalculation();
                    }, isIcon: true),
                  ],
                ),
                Row(
                  children: [
                    WidgetCalculator.numberEnter(context, '7',constraints.maxHeight, () {
                      cubit.inputNumber('7');
                    }, isFirst: true),
                    WidgetCalculator.numberEnter(context, '8',constraints.maxHeight, () {
                      cubit.inputNumber('8');
                    }),
                    WidgetCalculator.numberEnter(context, '9',constraints.maxHeight, () {
                      cubit.inputNumber('9');
                    }),
                    WidgetCalculator.calculation(context, 'assets/icons/divide.png',constraints.maxHeight, () {
                      cubit.addCalculation("/");
                      cubit.continueCalculation();
                    }, isIcon: true),
                  ],
                ),
                Row(
                  children: [
                    WidgetCalculator.calculation(context, 'assets/icons/plus_minus.png',constraints.maxHeight, () {
                      cubit.positiveOrNegative();
                    }, isFirst: true, isIcon: true),
                    WidgetCalculator.numberEnter(context, '0',constraints.maxHeight, () {
                      cubit.inputNumber('0');
                    }),
                    WidgetCalculator.numberEnter(context, '.',constraints.maxHeight, () {
                      cubit.inputNumber('.');
                    }),
                    WidgetCalculator.calculation(context, '=',constraints.maxHeight, () {
                      cubit.equal();
                    }),
                  ],
                ),
              ],
            ),
          ))
        ],
      ),
    ));
  }
}