part of 'news_bloc.dart';

abstract class NewsState extends BaseState<NewsState> {}

class NewsInitial extends NewsState {}

class NewsBbcSuccessState extends NewsState {
  final String? data;

  NewsBbcSuccessState({this.data});
}

class NewsBbcFailedState extends NewsState {
  String? message;

  NewsBbcFailedState({this.message});
}

class NewsCnnSuccessState extends NewsState {
    final String? data;

  NewsCnnSuccessState({this.data});
}

class NewsCnnFailedState extends NewsState {
  String? message;

  NewsCnnFailedState({this.message});
}


