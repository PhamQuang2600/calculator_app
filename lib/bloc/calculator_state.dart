
part of'calculator_cubit.dart';
class CalculatorState extends Equatable{
  @override
  List<Object?> get props => [];
}

class CalculatorInitial extends CalculatorState{}
class CalculatorLoading extends CalculatorState{}
class CalculatorLoaded extends CalculatorState{}
class CalculatorError extends CalculatorState{}
