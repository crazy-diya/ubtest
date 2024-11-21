


import 'package:union_bank_mobile/features/data/models/responses/schedule_bill_payment_response.dart';

import '../../../data/models/responses/bill_payment_response.dart';
import '../../../data/models/responses/get_biller_list_response.dart';
import '../../../domain/entities/response/biller_category_entity.dart';
import '../../../domain/entities/response/saved_biller_entity.dart';
import '../base_state.dart';

abstract class BillerManagementState extends BaseState<BillerManagementState> {}

class InitialBillerManagementState extends BillerManagementState {}

class GetSavedBillersSuccessState extends BillerManagementState {
  final GetSavedBillersResponse? response;

  final List<SavedBillerEntity>? savedBillers;

  GetSavedBillersSuccessState({this.response,this.savedBillers});
}

class GetSavedBillersFailedState extends BillerManagementState {
  final String? message;

  GetSavedBillersFailedState({this.message});
}

class GetSavedBillersEmptyState extends BillerManagementState {
}

class AddBillerFailedState extends BillerManagementState {
  final String? message;

  AddBillerFailedState({this.message});
}

class AddBillerSuccessState extends BillerManagementState {
  final int? billerId;
  final String? responseDes;
  final String? responseCode;

  AddBillerSuccessState({this.billerId , this.responseDes , this.responseCode});
}

class FavouriteBillerSuccessState extends BillerManagementState {
  final String? message;

  FavouriteBillerSuccessState({this.message});
}

class FavouriteBillerFailedState extends BillerManagementState {
  final String? message;

  FavouriteBillerFailedState({this.message});
}

class DeleteBillerSuccessState extends BillerManagementState {
  final String? message;
  final List<int>?  id;

  DeleteBillerSuccessState({this.message , this.id});
}

class DeleteBillerFailedState extends BillerManagementState {
  final String? message;

  DeleteBillerFailedState({this.message});
}

class GetBillerCategoryListFailedState extends BillerManagementState {
  final String? message;

  GetBillerCategoryListFailedState({this.message});
}

class GetBillerCategorySuccessState extends BillerManagementState {
  final List<BillerCategoryEntity>? billerCategoryList;

  GetBillerCategorySuccessState({this.billerCategoryList});
}

class EditUserBillerSuccessState extends BillerManagementState {
  final int? billerId;
  final String? responseDes;
  final String? responseCode;

  EditUserBillerSuccessState(
      {this.billerId, this.responseDes, this.responseCode});
}

class EditUserBillerFailedState extends BillerManagementState {
  final String? message;

  EditUserBillerFailedState({this.message});
}

class UnFavouriteBillerSuccessState extends BillerManagementState {
  final int? billerId;

  UnFavouriteBillerSuccessState({this.billerId});
}

class UnFavouriteBillerFailedState extends BillerManagementState {
  final String? message;

  UnFavouriteBillerFailedState({this.message});
}

/// Bill Payment
class BillPaymentSuccessState extends BillerManagementState {
  final BillPaymentResponse? billPaymentResponse;
  final String? message;

  BillPaymentSuccessState({this.billPaymentResponse,this.message});
}

class BillPaymentFailedState extends BillerManagementState {
  final String? message;
  final String? refId;

  BillPaymentFailedState({this.message,this.refId});
}

///pdf
class BillerPdfDownloadSuccessState extends BillerManagementState{
  final String? document;
  final bool? shouldOpen;
  BillerPdfDownloadSuccessState({this.document,this.shouldOpen});

}
class BillerPdfDownloadFailedState extends BillerManagementState{
  final String? message;
  BillerPdfDownloadFailedState({this.message});

}

///excel
class BillerExcelDownloadSuccessState extends BillerManagementState{
  final String? document;
  final bool? shouldOpen;
  BillerExcelDownloadSuccessState({this.document,this.shouldOpen});

}
class BillerExcelDownloadFailedState extends BillerManagementState{
  final String? message;
  BillerExcelDownloadFailedState({this.message});

}


class SchedulingBillPaymentSuccessState extends BillerManagementState {
  ScheduleBillPaymentResponse? scheduleBillPaymentResponse;
  SchedulingBillPaymentSuccessState({this.scheduleBillPaymentResponse,});
}

class SchedulingBillPaymentFailedState extends BillerManagementState {
  final String? message;
  final String? code;

  SchedulingBillPaymentFailedState({this.message,this.code});
}
