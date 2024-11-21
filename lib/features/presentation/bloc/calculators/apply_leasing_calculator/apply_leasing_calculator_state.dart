part of 'apply_leasing_calculator_bloc.dart';

@immutable
abstract class ApplyLeasingCalculatorState extends BaseState<ApplyLeasingCalculatorState> {}

class ApplyLeasingCalculatorInitial extends ApplyLeasingCalculatorState {}

class ApplyLeasingCalculatorFieldDataSuccessState extends ApplyLeasingCalculatorState {
  final String? responseCode;
  final String? responseDescription;

  ApplyLeasingCalculatorFieldDataSuccessState({this.responseCode,this.responseDescription});
}

class ApplyLeasingCalculatorFieldDataFailedState extends ApplyLeasingCalculatorState {
  final String? message;

  ApplyLeasingCalculatorFieldDataFailedState({this.message});
}
