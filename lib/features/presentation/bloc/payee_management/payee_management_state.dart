
import '../../../data/models/responses/delete_fund_transfer_payee_response.dart';
import '../../../data/models/responses/fund_transfer_payee_list_response.dart';

import '../base_state.dart';

abstract class PayeeManagementState extends BaseState<PayeeManagementState> {}

class InitialPayeeManagementState extends PayeeManagementState {}

class GetSavedPayeesSuccessState extends PayeeManagementState {
  final List<PayeeResponseData>? savedPayees;

  GetSavedPayeesSuccessState({this.savedPayees,});
}

class GetSavedPayeeFailedState extends PayeeManagementState {
  final String? message;

  GetSavedPayeeFailedState({this.message});
}

class AddPayeeSuccessState extends PayeeManagementState {
  final int? payeeId;
  final String? message;
  final String? responseCode;

  AddPayeeSuccessState({this.message, this.payeeId , this.responseCode});
}

class AddPayeeFailedState extends PayeeManagementState {
  final String? message;
  final String? code;

  AddPayeeFailedState({this.message,this.code});
}

class EditPayeeFailedState extends PayeeManagementState {
  final String? message;
  final String? code;

  EditPayeeFailedState({this.message,this.code});

}

class EditPayeeSuccessState extends PayeeManagementState {
  final String? message;
  final String? errorCode;

  EditPayeeSuccessState({this.message , this.errorCode});

}

class DeletePayeeSuccessState extends PayeeManagementState {
  final String? message;
  final List<PayeeDataResponseDtoList>? deletePayees;


  DeletePayeeSuccessState({this.deletePayees,this.message});
}

class DeletePayeeFailedState extends PayeeManagementState {
  final String? message;

  DeletePayeeFailedState({this.message});
}

class FavoritePayeeSuccessState extends PayeeManagementState {
  final String? message;

  FavoritePayeeSuccessState({this.message});
}

class FavoritePayeeFailedState extends PayeeManagementState {
  final String? message;

  FavoritePayeeFailedState({this.message});
}

class GetPayeeBranchSuccessState<T> extends PayeeManagementState {
  final T data;

  GetPayeeBranchSuccessState({required this.data});
}

class GetPayeeBranchFaildState extends PayeeManagementState {
  final String? message;

  GetPayeeBranchFaildState({this.message});
}
