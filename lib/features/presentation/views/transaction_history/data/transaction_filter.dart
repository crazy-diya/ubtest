import 'package:union_bank_mobile/features/data/models/responses/city_response.dart';

class TransactionFilter {
  bool? isFiltered;
  String? selectedAccount;
  String? fromDate;
  String? toDate;
  double? fromAmount;
  double? toAmount;
  CommonDropDownResponse? transactionType;
  String? channel;

  TransactionFilter({
    this.isFiltered,
    this.selectedAccount,
    this.fromDate,
    this.toDate,
    this.fromAmount,
    this.toAmount,
    this.transactionType,
    this.channel,
  });
}