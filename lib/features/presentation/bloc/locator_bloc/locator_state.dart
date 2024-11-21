import '../../../data/models/responses/get_locator_response.dart';


import '../base_state.dart';

abstract class LocatorState extends BaseState <LocatorState>{}

class InitialLocatorState extends LocatorState {}

class GetLocatorLoadingState extends LocatorState {}

class GetLocatorLoadedState extends LocatorState {
  final List <Atm>? branchData;
  final List <Atm>? atmData;
  final List <Atm>? cdmData;
  final List <Atm>? allData;
  final List <String>? services;




  GetLocatorLoadedState( {this.branchData, this.atmData, this.allData,this.cdmData,this.services});
}

class GetLocatorFailedState extends LocatorState {
  final String? errorMessage;

  GetLocatorFailedState({this.errorMessage});
}
