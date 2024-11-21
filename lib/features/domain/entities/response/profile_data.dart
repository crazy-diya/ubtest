import 'package:flutter/services.dart';

class ProfileData{
  String? cName;
  String? userName;
  String? mobileNo;
  String? name;
  String? email;
  String? nic;
  String? profileImageKey;
  String? fName;
  Uint8List? profileImage;

  ProfileData(
      {this.cName,
        this.userName,
        this.mobileNo,
        this.name,
        this.email,
        this.nic,
        this.profileImageKey,
        this.fName,
        this.profileImage});
}