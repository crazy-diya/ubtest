part of 'apply_fd_calculator_bloc.dart';

@immutable
abstract class ApplyFDCalculatorState extends BaseState<ApplyFDCalculatorState> {}

class ApplyFDCalculatorInitial extends ApplyFDCalculatorState {}

class ApplyFDCalculatorFieldDataSuccessState extends ApplyFDCalculatorState {
  final String? responseCode;
  final String? responseDescription;

  ApplyFDCalculatorFieldDataSuccessState({this.responseDescription, this.responseCode});
}

class ApplyFDCalculatorFieldDataFailedState extends ApplyFDCalculatorState {
  final String? message;

  ApplyFDCalculatorFieldDataFailedState({this.message});
}