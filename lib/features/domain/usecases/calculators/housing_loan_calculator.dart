import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/data/models/requests/housing_loan_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/housing_loan_response.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class HousingLoanCalculatorData extends UseCase<BaseResponse<HousingLoanResponseModel>,
    HousingLoanRequestModel> {
  final Repository? repository;

  HousingLoanCalculatorData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<HousingLoanResponseModel>>> call(
      HousingLoanRequestModel params) {
    return repository!.housingLoanList(params);
  }
}