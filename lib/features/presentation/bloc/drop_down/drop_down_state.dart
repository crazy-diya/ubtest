part of 'drop_down_bloc.dart';

@immutable
abstract class DropDownState extends BaseState<DropDownState> {}

class InitialDropDownState extends DropDownState {}

class DropDownDataLoadedState<T> extends DropDownState {
  final T data;

  DropDownDataLoadedState({required this.data});
}

class DropDownFilteredState<T> extends DropDownState {
  final T data;

  DropDownFilteredState({required this.data});
}

class DropDownFailedState extends DropDownState {
  final String? message;

  DropDownFailedState({required this.message});
}
