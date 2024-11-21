
import 'package:fpdart/fpdart.dart';
import 'package:equatable/equatable.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../entities/request/customer_reg_request_entity.dart';
import '../../repository/repository.dart';
import '../usecase.dart';

class CustomerRegistration extends UseCase<BaseResponse, CustomerRegParams> {
  final Repository? repository;

  CustomerRegistration({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(CustomerRegParams params) async {
    return repository!.registerCustomer(params.customerRegistrationRequestEntity);
  }
}

class CustomerRegParams extends Equatable {
  final CustomerRegistrationRequestEntity customerRegistrationRequestEntity;

  const CustomerRegParams({required this.customerRegistrationRequestEntity});

  @override
  List<Object> get props => [customerRegistrationRequestEntity];
}