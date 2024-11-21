

import '../base_event.dart';

abstract class QuickAccessEvent extends BaseEvent {}

class AddQuickAccessEvent extends QuickAccessEvent {
  final List<String>? ids;

  AddQuickAccessEvent({this.ids});
}

class AddQuickAccessEventWhenPop extends QuickAccessEvent {
  final List<String>? ids;

  AddQuickAccessEventWhenPop({this.ids});
}
// class RemoveQuickAccessEvent extends QuickAccessEvent {
//   final List<String>? ids;

//   RemoveQuickAccessEvent({this.ids});
// }

class GetQuickAccessEvent extends QuickAccessEvent {
  GetQuickAccessEvent();
}
