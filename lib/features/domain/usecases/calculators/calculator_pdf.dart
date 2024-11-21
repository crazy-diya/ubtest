import 'package:fpdart/fpdart.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/calculator_share_pdf_request.dart';
import '../../../data/models/responses/calculator_share_pdf_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class CalculatorPDF extends UseCase<BaseResponse<CalculatorPdfResponse>,
    CalculatorPdfRequest> {
  final Repository? repository;

  CalculatorPDF({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CalculatorPdfResponse>>> call(
      CalculatorPdfRequest params) {
    return repository!.calculatorPDF(params);
  }
}