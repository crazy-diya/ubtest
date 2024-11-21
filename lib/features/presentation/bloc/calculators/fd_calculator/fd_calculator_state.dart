part of 'fd_calculator_bloc.dart';

@immutable
abstract class FDCalculatorState
    extends BaseState<FDCalculatorState> {}

class FDCalculatorInitial extends FDCalculatorState {}

class FDCalculatorFieldDataSuccessState extends FDCalculatorState {
  // final HousingLoanResponseModel? response;
  //
  // HousingLoanFieldDataSuccessState({this.response});

  final String? currencyCode;
  final String? currency;
  final String? monthlyValue;
  final String? nominalRate;
  final String? monthlyRate;
  final String? maturityValue;

  FDCalculatorFieldDataSuccessState(
      {this.currencyCode,
      this.currency,
      this.monthlyValue,
      this.nominalRate,
      this.monthlyRate,
      this.maturityValue});
}

class FDCalculatorFieldDataFailedState extends FDCalculatorState {
  final String? message;

  FDCalculatorFieldDataFailedState({this.message});
}

class FDCalculatorPDFSuccessState extends FDCalculatorState {
  final String? document;
  final bool? shouldOpen;

  FDCalculatorPDFSuccessState({this.document, this.shouldOpen});
}

class FDCalculatorPDFFailedState extends FDCalculatorState {
  final String? message;

  FDCalculatorPDFFailedState({this.message});
}

class GetFDRateSuccessState extends FDCalculatorState {
  final List<FdRatesCbsResponseDtoList>? fdRatesCbsResponseDtoList;

  GetFDRateSuccessState({this.fdRatesCbsResponseDtoList});
}

class GetFDRateFailedState extends FDCalculatorState {
  final String? message;

  GetFDRateFailedState({this.message});
}

class GetFDDataLoadedState extends FDCalculatorState {
  final List<CurrencyResponse>? data;

  GetFDDataLoadedState({this.data});
}

class  GetFDDataFailedState extends FDCalculatorState {
  final String? message;

  GetFDDataFailedState({this.message});
}

class GetFDPeriodLoadedState extends FDCalculatorState {
  final List<FDPeriodResponse>? data;

  GetFDPeriodLoadedState({this.data});
}

class  GetFDPeriodFailedState extends FDCalculatorState {
  final String? message;

  GetFDPeriodFailedState({this.message});
}
