import 'package:equatable/equatable.dart';

class ErrorResponse extends Equatable {
  final String? errorCode;
  final String? errorDescription;

  const ErrorResponse({
    this.errorCode,
    this.errorDescription
  });

  @override
  List<Object?> get props => [errorCode, errorDescription];
}