// To parse this JSON data, do
//
//     final createUserRequest = createUserRequestFromJson(jsonString);

import '../../../data/models/requests/create_user_request.dart';

class CreateUserEntity extends CreateUserRequest {
  const CreateUserEntity({
    this.messageType,
    this.username,
    this.password,
    this.confirmPassword,
    this.onBoardedType,
  }) : super(
            messageType: messageType,
            confirmPassword: confirmPassword,
            password: password,
            username: username,
            onBoardedType: onBoardedType);

  final String? messageType;
  final String? username;
  final String? password;
  final String? confirmPassword;
  final String? onBoardedType;
}
