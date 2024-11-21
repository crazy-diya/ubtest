part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsEvent extends BaseEvent {}

class GetNotificationsEvent extends NotificationsEvent {
  final int page;
  final int size;
  final String readStatus;

  GetNotificationsEvent({required this.page, required this.size, required this.readStatus});
}

class GetPromotionEvent extends NotificationsEvent {
  final int page;
  final int size;
  final String readStatus;

  GetPromotionEvent({required this.page, required this.size, required this.readStatus});
}

class GetNoticesEvent extends NotificationsEvent {
  final int page;
  final int size;
  final String epicUserId;
  final String readStatus;

  GetNoticesEvent(
      {required this.page, required this.size, required this.epicUserId, required this.readStatus});
}

class MarkNotificationAsReadEvent extends NotificationsEvent {
  final List<int>? notifications;
  final String epicUserId;

  MarkNotificationAsReadEvent({this.notifications , required this.epicUserId});
}

class DeleteNotificationEvent extends NotificationsEvent {
  final String? epicUserId;
  final int? page;
  final int? size;
  final List<int>? notificationIds;

  DeleteNotificationEvent(
      {this.epicUserId, this.page, this.size, this.notificationIds});
}

class CountNotificationsEvent extends NotificationsEvent {
  final String? readStatus;
  final String? notificationType;

  CountNotificationsEvent({this.readStatus, this.notificationType});
}

class MoneyRequestNotificationEvent extends NotificationsEvent {
  final String? messageType;
  final String? requestMoneyId;

  MoneyRequestNotificationEvent({this.messageType, this.requestMoneyId});
}

class ReqMoneyNotificationStatusEvent extends NotificationsEvent {
  final String? messageType;
  final String? requestMoneyId;
  final String? status;
  final String? transactionStatus;

  ReqMoneyNotificationStatusEvent(
      {this.messageType, this.requestMoneyId, this.status,this.transactionStatus});
}
