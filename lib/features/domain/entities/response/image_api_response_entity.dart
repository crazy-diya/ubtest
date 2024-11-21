import 'dart:typed_data';

class ImageApiResponseEntity {
  ImageApiResponseEntity({
    this.imageKey,
    this.imageType,
    this.image,
    this.callingName,
    this.name
  });

  String? imageKey;
  String? imageType;
  Uint8List? image;
  String? callingName;
  String? name;
}
