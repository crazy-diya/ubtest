// ignore: directives_ordering
import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/data/models/requests/bill_payment_excel_dwnload_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/bill_payment_excel_dwnload_response.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class BillerExcelDownload extends UseCase<BaseResponse<BillPaymentExcelDownloadResponse>,
    BillPaymentExcelDownloadRequest> {
  final Repository? repository;

  BillerExcelDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<BillPaymentExcelDownloadResponse>>> call(
      BillPaymentExcelDownloadRequest params) async {
    return await repository!.billerExcelDownload(params);
  }
}
