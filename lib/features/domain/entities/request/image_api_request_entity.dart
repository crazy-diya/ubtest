import '../../../data/models/requests/image_api_request_model.dart';

class ImageApiRequestEntity extends ImageApiRequestModel {
  ImageApiRequestEntity({
    this.imageKey,
    this.imageType,
    this.messageType,
  });

  String? imageKey;
  String? imageType;
  String? messageType;
}
