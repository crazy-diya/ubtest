import 'package:union_bank_mobile/features/presentation/views/service_request/data/service_charge_entity.dart';
import 'package:union_bank_mobile/features/presentation/views/service_request/data/service_req_entity.dart';

import '../../../../../utils/enums.dart';

class ServiceReqArgs{
  ServiceReqEntity? serviceReqEntity;
  final ServiceReqType serviceReqType;
  final ServiceChargeEntity serviceChargeEntity;

  ServiceReqArgs(this.serviceReqEntity , this.serviceReqType, this.serviceChargeEntity);
}