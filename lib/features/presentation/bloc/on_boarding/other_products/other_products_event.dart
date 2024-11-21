import '../../base_event.dart';

abstract class OtherProductsEvent extends BaseEvent {}

class GetOtherProductsEvent extends OtherProductsEvent {}

class SubmitOtherProductsEvent extends OtherProductsEvent {
  final List<int?>? data;

  SubmitOtherProductsEvent({this.data});
}

class SaveOtherProductsEvent extends OtherProductsEvent {}

class SaveUserEvent extends OtherProductsEvent {}
