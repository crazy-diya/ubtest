import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/card_taransaction_pdf.dart';
import '../../../data/models/responses/card_transaction_pdf.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class CardTransactionPdfDownload extends UseCase<BaseResponse<CardTransactionPdfResponse>, CardTransactionPdfRequest> {
  final Repository? repository;

  CardTransactionPdfDownload({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CardTransactionPdfResponse>>>
  call(CardTransactionPdfRequest params) {
    return repository!.cardTranPdfDownload(params);
  }
}
