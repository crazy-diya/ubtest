part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends BaseEvent{}

class ResetCurrentPasswordEvent extends ResetPasswordEvent{
  final String? newPassword;
  final String? oldPassword;
  final String? confirmPassword;
  final bool isAdminPasswordReset;

  ResetCurrentPasswordEvent( {this.newPassword, this.oldPassword, this.confirmPassword,required this.isAdminPasswordReset,});
}

class TemporaryResetEvent extends ResetPasswordEvent {
  final String? username;
  final String? password;

  TemporaryResetEvent( {this.username, this.password,});
}
