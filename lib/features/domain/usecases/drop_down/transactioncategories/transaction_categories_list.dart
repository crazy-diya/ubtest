import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../../data/models/common/base_response.dart';
import '../../../../data/models/requests/transaction_categories_list_request.dart';
import '../../../../data/models/responses/transaction_categories_list_response.dart';
import '../../../repository/repository.dart';
import '../../usecase.dart';

class GetTransactionCategoriesList
    extends UseCase<BaseResponse<TransactionCategoriesListResponse>, TransactionCategoriesListRequest> {
  final Repository? repository;

  GetTransactionCategoriesList({this.repository});

  @override
  Future<Either<Failure, BaseResponse<TransactionCategoriesListResponse>>> call(
      TransactionCategoriesListRequest params) async {
    return await repository!.transactionCategoriesList(params);
  }
}
