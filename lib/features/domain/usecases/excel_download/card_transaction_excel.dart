import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/card_tran_excel_download.dart';
import '../../../data/models/responses/card_tran_excel_download.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class CardTransactionExcelDownload extends UseCase<BaseResponse<CardTransactionExcelResponse>, CardTransactionExcelRequest> {
  final Repository? repository;

  CardTransactionExcelDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CardTransactionExcelResponse>>>
  call(CardTransactionExcelRequest params) {
    return repository!.cardTranExcelDownload(params);
  }
}
