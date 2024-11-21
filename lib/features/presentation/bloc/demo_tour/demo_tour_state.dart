part of 'demo_tour_bloc.dart';

abstract class DemoTourState extends BaseState<DemoTourState> {}

class DemoTourInitial extends DemoTourState {}

class DemoTourSuccessState extends DemoTourState {
  final DemoTourListResponse? demoTourList;

  DemoTourSuccessState({this.demoTourList});
}

class DemoTourFailedState extends DemoTourState {
  final String? message;

  DemoTourFailedState({this.message});
}


