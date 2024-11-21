// ignore_for_file: must_be_immutable

part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsState extends BaseState<NotificationsState> {}

class NotificationsInitial extends NotificationsState {}

class NotificationSuccessState extends NotificationsState {
  final int? count;
  final List<UserNotificationResponseDtoList>? notifications;

  NotificationSuccessState({this.notifications,this.count});
}

class NotificationFailedState extends NotificationsState {
  String? message;

  NotificationFailedState({this.message});
}

class PromotionSuccessState extends NotificationsState {
  final int? count;
  final List<PromotionNotificationResponseDtoList>? notifications;

  PromotionSuccessState({this.notifications,this.count});
}

class PromotionFailedState extends NotificationsState {
  String? message;

  PromotionFailedState({this.message});
}


class NoticesSuccessState extends NotificationsState {
  final int? count;
  final List<NoticesNotificationResponseDtoList>? notifications;

  NoticesSuccessState({this.notifications,this.count});
}

class NoticesFailedState extends NotificationsState {
  String? message;

  NoticesFailedState({this.message});
}

class MarkAsReadNotificationSuccessState extends NotificationsState {
  final String? message;

  MarkAsReadNotificationSuccessState({this.message});
}

class MarkAsReadNotificationFailedState extends NotificationsState {
  final String? message;

  MarkAsReadNotificationFailedState({this.message});
}


class DeleteNotificationSuccessState extends NotificationsState {
  final String? message;

  DeleteNotificationSuccessState({this.message});
}

class DeleteNotificationFailedState extends NotificationsState {
  final String? message;

  DeleteNotificationFailedState({this.message});
}


class CountNotificationSuccessState extends NotificationsState {
  final int? allNotificationCount;
  final int? promoNotificationCount;
  final int? tranNotificationCount;
  final int? noticesNotificationCount;

  CountNotificationSuccessState(
      {
      this.allNotificationCount,
      this.promoNotificationCount,
      this.tranNotificationCount,
      this.noticesNotificationCount});
}

class CountNotificationFailedState extends NotificationsState {
  final String? message;

  CountNotificationFailedState({this.message});
}

class MoneyRequestNotificationSuccessState extends NotificationsState {
  final int? id;
  final String? toAccount;
  final String? toAccountName;
  final String? toBankCode;
  final num? requestedAmount;
  final DateTime? requestedDate;

  MoneyRequestNotificationSuccessState(
      {this.id,
      this.toAccount,
      this.toAccountName,
      this.toBankCode,
      this.requestedAmount,
      this.requestedDate});
}

class MoneyRequestNotificationFailedState extends NotificationsState {
  final String? message;

  MoneyRequestNotificationFailedState({this.message});
}

class ReqMoneyNotificationStatusSuccessState extends NotificationsState {
  final String? id;
  final String? description;

  ReqMoneyNotificationStatusSuccessState({this.id, this.description});
}

class ReqMoneyNotificationStatusFailedState extends NotificationsState {
  final String? message;

  ReqMoneyNotificationStatusFailedState({this.message});
}

