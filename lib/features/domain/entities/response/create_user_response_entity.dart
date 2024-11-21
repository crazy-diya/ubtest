// To parse this JSON data, do
//
//     final createUserResponse = createUserResponseFromJson(jsonString);

import 'package:equatable/equatable.dart';

class CreateUserResponseEntity extends Equatable {
  const CreateUserResponseEntity({
    this.data,
  });

  final UserDataEntity? data;

  @override
  List<Object?> get props => [data];
}

class UserDataEntity {
  UserDataEntity({
    this.epicUserId,
  });

  final String? epicUserId;
}
