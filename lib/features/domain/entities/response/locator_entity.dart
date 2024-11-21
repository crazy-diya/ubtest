// ignore_for_file: public_member_api_docs, sort_constructors_first
class LocatorEntity {
  String? merchantName;
  String? landMark;
  String? status;
  String? address;
  String? startTime;
  String? endTime;
  int? startDayOfWeek;
  int? endDayOfWeek;
  String? availableTime;
  String? latitude;
  String? longitude;
  String? telNumber;
  String? email;
  String? city;
  String? locationCategory;
  List? services;

  LocatorEntity(
      {this.merchantName,
      this.status,
      this.landMark,
      this.email,
      this.city,
      this.startTime,
      this.endTime,
      this.startDayOfWeek,
      this.endDayOfWeek,
      this.address,
      this.availableTime,
      this.latitude,
      this.longitude,
      this.telNumber,
      this.services,
      this.locationCategory});

  @override
  String toString() {
    return 'LocatorEntity(merchantName: $merchantName, landMark: $landMark, status: $status, address: $address, startTime: $startTime, endTime: $endTime, startDayOfWeek: $startDayOfWeek, endDayOfWeek: $endDayOfWeek, availableTime: $availableTime, latitude: $latitude, longitude: $longitude, telNumber: $telNumber, email: $email, city: $city, locationCategory: $locationCategory, services: $services)';
  }

  @override
  bool operator ==(covariant LocatorEntity other) {
    if (identical(this, other)) return true;
  
    return 
      other.merchantName == merchantName &&
      other.landMark == landMark &&
      other.status == status &&
      other.address == address &&
      other.startTime == startTime &&
      other.endTime == endTime &&
      other.startDayOfWeek == startDayOfWeek &&
      other.endDayOfWeek == endDayOfWeek &&
      other.availableTime == availableTime &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.telNumber == telNumber &&
      other.email == email &&
      other.city == city &&
      other.locationCategory == locationCategory &&
      other.services == services;
  }

  @override
  int get hashCode {
    return merchantName.hashCode ^
      landMark.hashCode ^
      status.hashCode ^
      address.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startDayOfWeek.hashCode ^
      endDayOfWeek.hashCode ^
      availableTime.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      telNumber.hashCode ^
      email.hashCode ^
      city.hashCode ^
      locationCategory.hashCode ^
      services.hashCode;
  }
}
