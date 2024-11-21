// To parse this JSON data, do
//
//     final saveAndExist = saveAndExistFromJson(jsonString);

import 'dart:convert';

SaveAndExist saveAndExistFromJson(String str) => SaveAndExist.fromJson(json.decode(str));

String saveAndExistToJson(SaveAndExist data) => json.encode(data.toJson());

class SaveAndExist {
    String? mobilenumber;
    String? email;
    String? nic;
    String? image1;
    String? image2;
    String? image3;

    SaveAndExist({
        this.mobilenumber,
        this.email,
        this.nic,
        this.image1,
        this.image2,
        this.image3,
    });

    factory SaveAndExist.fromJson(Map<String, dynamic> json) => SaveAndExist(
        mobilenumber: json["mobilenumber"],
        email: json["email"],
        nic: json["nic"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
    );

    Map<String, dynamic> toJson() => {
        "mobilenumber": mobilenumber,
        "email": email,
        "nic": nic,
        "image1": image1,
        "image2": image2,
        "image3": image3,
    };
}
