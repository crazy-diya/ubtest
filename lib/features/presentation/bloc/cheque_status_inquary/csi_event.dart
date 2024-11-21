part of 'csi_bloc.dart';

abstract class CSIEvent extends BaseEvent{}

class CSISuccessEvent extends CSIEvent{
  final bool? checkAllAccount;
  final String? accountNo;
  final String? accountType;
  final DateTime? fromDate;
  final DateTime? toDate;

  CSISuccessEvent(
      {this.checkAllAccount,
      this.accountNo,
      this.accountType,
      this.fromDate,
      this.toDate});
}