import '../base_event.dart';

abstract class PayeeManagementEvent extends BaseEvent {}

class GetSavedPayeesEvent extends PayeeManagementEvent {

}

class AddPayeeEvent extends PayeeManagementEvent {
  final String? nikname;
  final String? bankcode;
  final String? accountnumber;
  final String? holdername;
  final bool? addfavorite;
  final String? branchCode;
   final bool verified;

  AddPayeeEvent(
      {this.nikname,
        this.bankcode,
        this.accountnumber,
        this.holdername,
        this.addfavorite,
        this.branchCode,
        required this.verified
      });
}

// class AddPayeeEvent extends PayeeManagementEvent {
// final SavedPayeeEntity savedPayeeEntitiy;
// final bool addfavorite;
//
//   AddPayeeEvent(
//       {required this.savedPayeeEntitiy, required this.addfavorite,});
// }

class DeleteFundTransferPayeeEvent extends PayeeManagementEvent {
  final List<String>? deleteAccountList;

  DeleteFundTransferPayeeEvent({this.deleteAccountList});
}

class EditPayeeEvent extends PayeeManagementEvent {
  final int? payeeId;
  final String? nikname;
  final String? bankcode;
  final String? branchCode;
  final String? accountnumber;
  final String? holdername;
  final bool? addfavorite;

  EditPayeeEvent(
      {this.nikname,
      this.payeeId,
      this.bankcode,
        this.branchCode,
      this.accountnumber,
      this.holdername,
      this.addfavorite});
}

class FavoriteUnFavoritePayeeEvent extends PayeeManagementEvent{
  final int? id;
  final bool? favorite;
  FavoriteUnFavoritePayeeEvent({this.id,this.favorite});
}

class GetPayeeBankBranchEvent extends PayeeManagementEvent {
  final String bankCode;

  GetPayeeBankBranchEvent({required this.bankCode});
}
