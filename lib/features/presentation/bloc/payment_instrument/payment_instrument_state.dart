import 'package:union_bank_mobile/features/data/models/responses/account_details_response_dtos.dart';

import '../../../data/models/common/base_response.dart';
import '../../../data/models/responses/get_user_inst_response.dart';
import '../base_state.dart';

abstract class PaymentInstrumentState extends BaseState<PaymentInstrumentState> {}

class InitialPaymentInstrumentState extends PaymentInstrumentState {}

class GetPaymentInstrumentSuccessState extends PaymentInstrumentState {
  final List<UserInstruments>? getUserInstList;
  GetPaymentInstrumentSuccessState({this.getUserInstList});
}
class GetPaymentInstrumentFailedState extends PaymentInstrumentState {
  final String? message;

  GetPaymentInstrumentFailedState({this.message});
}
/// Select DefaultPayment Instrument
class SelectDefaultPaymentInstrumentFailedState extends PaymentInstrumentState {
  final String? message;

  SelectDefaultPaymentInstrumentFailedState({this.message});
}

class SelectDefaultPaymentInstrumentSuccessState extends PaymentInstrumentState {
  final BaseResponse? baseResponse;

  SelectDefaultPaymentInstrumentSuccessState({this.baseResponse});

}
/// Add Instrument Payments
class AddPaymentInstrumentFailedState extends PaymentInstrumentState {
  final String? message;
  final String? code;


  AddPaymentInstrumentFailedState({this.message,this.code });
}

class AddPaymentInstrumentSuccessState extends PaymentInstrumentState {
  final BaseResponse? baseResponse;
final String? code;
final String? responseDescription;
  AddPaymentInstrumentSuccessState({this.baseResponse, this.code,this.responseDescription});

}

/// Instrument Status Change
class InstrumentStatusChangeFailedState extends PaymentInstrumentState {
  final String? message;

  InstrumentStatusChangeFailedState({this.message});
}

class InstrumentStatusChangeSuccessState extends PaymentInstrumentState {
  final BaseResponse? baseResponse;

  InstrumentStatusChangeSuccessState({this.baseResponse});

}

/// Instrument Nick Name Change
class InstrumentNikNameChangeFailedState extends PaymentInstrumentState {
  final String? message;

  InstrumentNikNameChangeFailedState({this.message});
}

class InstrumentNikNameChangeSuccessState extends PaymentInstrumentState {
  final BaseResponse? baseResponse;
  final String? responseCode;
  final String? responseDescription;

  InstrumentNikNameChangeSuccessState({this.baseResponse , this.responseCode , this.responseDescription});

}

/// Instrument Delete
class DeleteJustPayInstrumentFailedState extends PaymentInstrumentState {
  final String? message;

  DeleteJustPayInstrumentFailedState({this.message});
}

class DeleteJustPayInstrumentSuccessState extends PaymentInstrumentState {
  final BaseResponse? baseResponse;
  final String? message;
  final String? code;

  DeleteJustPayInstrumentSuccessState({this.baseResponse , this.message , this.code});

}

class ManageAccountDetailsSuccessState extends PaymentInstrumentState {
  final AccountDetailsResponseDtos? accDetails;

  ManageAccountDetailsSuccessState({
    this.accDetails,
  });
}

class ManageAccountDetailFailState extends PaymentInstrumentState {
  final String? errorMessage;

  ManageAccountDetailFailState({this.errorMessage});
}



