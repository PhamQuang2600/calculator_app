import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calculator_state.dart';
class CalculatorCubit extends Cubit{
  CalculatorCubit() : super(CalculatorInitial());
  dynamic equalCalculator = 0;
  List<String> numberOne = [];
  List<String> numberTwo = [];
  bool isEqual = false;
  List<String> calculation = [];

 clean(){
   emit(CalculatorLoading());
    isEqual = false;
    calculation.clear();
    numberOne = [];
    numberTwo = [];
    equalCalculator = 0;
   emit(CalculatorLoaded());
 }

 addCalculation(String calculator){
   emit(CalculatorLoading());
   switch(calculator){
     case "*":
       calculation.add("*");
       break;
     case "/":
       calculation.add("/");
       break;
     case "+":
       calculation.add("+");
       break;
     case "-":
       calculation.add("-");
       break;
   }
   emit(CalculatorLoaded());
 }

 remove(){
   emit(CalculatorLoading());
   if(calculation.length == 1){
     if(numberTwo.isNotEmpty){
       numberTwo.removeLast();
     }else{
       calculation.removeLast();
     }
   }else{
     if(numberOne.isNotEmpty){
       numberOne.removeLast();
     }
   }
   emit(CalculatorLoaded());
 }

 continueCalculation(){
   if(isEqual){
     isEqual = false;
     numberOne.clear();
     numberTwo.clear();
     numberOne.addAll(equalCalculator.toString().split(''));
   }else{
     if(calculation.length>1){
       emit(CalculatorLoading());
       if(numberTwo.isNotEmpty){
         equal(isContinue: true);
         numberOne.clear();
         numberTwo.clear();
         numberOne.addAll(equalCalculator.toString().split(''));
       }
       calculation.removeAt(0);
       emit(CalculatorLoaded());
     }
   }

 }

 percentCal(){
   emit(CalculatorLoading());
   if(calculation.isNotEmpty){
     double convertNumberTwo = double.tryParse(numberTwo.join(''))??0;
     if(convertNumberTwo != 0){
       numberTwo.clear();
       numberTwo.addAll((convertNumberTwo / 100).toString().split(''));
     }
   }else{
     double convertNumberOne = double.tryParse(numberOne.join(''))??0;
     if(convertNumberOne != 0){
       numberOne.clear();
       numberOne.addAll((convertNumberOne / 100).toString().split(''));
     }
   }
   emit(CalculatorLoaded());
 }

 positiveOrNegative(){
   emit(CalculatorLoading());
   double convertNumberOne = double.tryParse(numberOne.join(''))??0;
   double convertNumberTwo = double.tryParse(numberTwo.join(''))??0;
   if(calculation.isNotEmpty){
     if(numberTwo.isNotEmpty){
       if(numberTwo.first=='-'){
         numberTwo.removeAt(0);
       }
       else{
         numberTwo.insert(0, '-');
       }
     }
   }else{
     if(numberOne.isNotEmpty){
       if(numberOne.first=='-'){
         numberOne.removeAt(0);
       }
       else{
         numberOne.insert(0, '-');
       }
     }
   }
   emit(CalculatorLoaded());
 }

 inputNumber(String number){
   if(isEqual){
     clean();
     if(numberOne.isEmpty && number =='0'){}else{
     if(numberOne.isEmpty && number =='.'){
       numberOne.addAll(['0',number]);
     }}
     if(numberOne.contains('.') && number =='.'){}else{
       numberOne.add(number);
     }
   }else{
     emit(CalculatorLoading());
     if(calculation.isNotEmpty){
       if(numberTwo.isEmpty && number =='0'){}else{
         if(numberTwo.isEmpty && number =='.'){
           numberTwo.addAll(['0',number]);
         }
         List<String> upTo16Number = [];
         if(numberTwo is double){
           upTo16Number.addAll(numberTwo.join('').split('.'));
           if(upTo16Number[0].length + upTo16Number[1].length < 16){
             if(numberTwo.contains('.') && number =='.'){}else{
               numberTwo.add(number);
             }
           }
         }else{
           if(numberTwo.length < 16){
             if(numberTwo.contains('.') && number =='.'){}else{
               numberTwo.add(number);
             }
           }
         }
       }
     }else{
       if(numberOne.isEmpty && number =='0'){}else{
         if(numberOne.isEmpty && number =='.'){
           numberOne.addAll(['0',number]);
         }
         List<String> upTo16Number = [];
         if(numberOne is double){
           upTo16Number.addAll(numberOne.join('').split('.'));
           if(upTo16Number[0].length + upTo16Number[1].length < 16){
             if(numberOne.contains('.') && number =='.'){}else{
               numberOne.add(number);
             }
           }
         }else{
           if(numberOne.length < 16){
             if(numberOne.contains('.') && number =='.'){}else{
               numberOne.add(number);
             }
           }
         }
       }
     }
     emit(CalculatorLoaded());
   }
 }

 convertToInt(dynamic number){
   if(number is double){
     List<String> getResultInt = number.toString().split('.');
     if(getResultInt[1].isNotEmpty){
       if(getResultInt[1] == '0'){
         equalCalculator = int.tryParse(getResultInt.first)??0;
       }else{
         equalCalculator = number;
       }
     }else{
       equalCalculator = int.tryParse(getResultInt.first)??0;
     }
   }else{
     equalCalculator = number;
   }
 }

  equal({bool? isContinue = false}) {
    if(calculation.isNotEmpty){
      emit(CalculatorLoading());
      double convertNumberOne = double.tryParse(numberOne.join(''))??0;
      double convertNumberTwo = double.tryParse(numberTwo.join(''))??0;
      switch(calculation.first){
        case '*':
          convertToInt(convertNumberOne * convertNumberTwo);
          break;
        case '/':
          convertToInt(convertNumberOne / convertNumberTwo);
          break;
        case '+':
          convertToInt(convertNumberOne + convertNumberTwo);
          break;
        case '-':
          convertToInt(convertNumberOne - convertNumberTwo);
          break;
      }
      if(isContinue == false){
        numberOne.clear();
        numberTwo.clear();
        isEqual = true;
        calculation.clear();
      }
      emit(CalculatorLoaded());
    }
 }

}