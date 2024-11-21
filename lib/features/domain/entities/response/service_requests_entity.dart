import '../../../../utils/enums.dart';

class ServiceRequestsEntity {
  String? serviceRequest;
  String? requestedDate;
  ServiceRequestStatus? status;
  String? reason;
  String? refNumber;

  ServiceRequestsEntity({
    this.serviceRequest,
    this.requestedDate,
    this.status,
    this.reason,
    this.refNumber
  });
}
