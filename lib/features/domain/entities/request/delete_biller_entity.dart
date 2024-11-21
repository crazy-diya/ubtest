

import '../../../data/models/requests/favourite_biller_request.dart';


class DeleteBillerEntity extends FavouriteBillerRequest {
  final String? messageType;
  final int? billerId;

  DeleteBillerEntity({this.messageType, this.billerId})
      : super(
          messageType: messageType,
          id: billerId,
        );
}
