part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends BaseEvent{}

class ChangeCurrentPasswordEvent extends ChangePasswordEvent{
  final String? newPassword;
  final String? oldPassword;
  final String? confirmPassword;

  ChangeCurrentPasswordEvent({this.newPassword, this.oldPassword, this.confirmPassword});
}
