part of 'news_bloc.dart';


abstract class NewsEvent extends BaseEvent {}

class GetBbcEvent extends NewsEvent {
}

class GetCnnEvent extends NewsEvent {
}
