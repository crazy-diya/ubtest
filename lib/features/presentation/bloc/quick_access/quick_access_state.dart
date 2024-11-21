
import '../base_state.dart';

abstract class QuickAccessState extends BaseState<QuickAccessState> {}

class InitialQuickAccessState extends QuickAccessState {}

class QuickAccessLoadSuccessState extends QuickAccessState {
  final List<String>? quickAccessList;

  QuickAccessLoadSuccessState({this.quickAccessList});
}

class QuickAccessLoadFailedState extends QuickAccessState {

  QuickAccessLoadFailedState();
}

class QuickAccessAddSuccessState extends QuickAccessState {
  final List<String>? quickAccessList;

  QuickAccessAddSuccessState({this.quickAccessList});
}

class QuickAccessAddFailedState extends QuickAccessState {

  QuickAccessAddFailedState();
}

class QuickAccessAddSuccessStateWhenPop extends QuickAccessState {
  final List<String>? quickAccessList;

  QuickAccessAddSuccessStateWhenPop({this.quickAccessList});
}

class QuickAccessAddFailedStateWhenPop extends QuickAccessState {

  QuickAccessAddFailedStateWhenPop();
}
