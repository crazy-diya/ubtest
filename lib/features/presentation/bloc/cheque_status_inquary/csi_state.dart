part of 'csi_bloc.dart';

abstract class CSIState extends BaseState<CSIState> {}

class CSIStateInitial extends CSIState {}

class CSISuccessState extends CSIState {
  final List<CsiDataList>? csiDataList;

  CSISuccessState({this.csiDataList});
}

class CSIFailState extends CSIState {
  final String? responseCode;
  final String? responseDescription;

  CSIFailState({
    this.responseCode,
    this.responseDescription,
  });
}

