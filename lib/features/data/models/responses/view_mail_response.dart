// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final temperatures = temperaturesFromJson(jsonString);

// import 'dart:convert';

// import 'package:flutter/services.dart';
// import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
// import 'package:union_bank_mobile/utils/app_utils.dart';

// ViewMailResponse viewMailResponseFromJson(String str) => ViewMailResponse.fromJson(json.decode(str));

// String viewMailResponseToJson(ViewMailResponse data) => json.encode(data.toJson());

// class ViewMailResponse extends Serializable{
//     final int? mailThreadCount;
//     final int? totalUnread;
//     final List<ViewMailData>? viewInboxData;
//     final List<ViewMailData>? viewSentData;
//     final List<ViewMailData>? viewDraftData;

//     ViewMailResponse({
//         this.mailThreadCount,
//         this.totalUnread,
//         this.viewInboxData,
//         this.viewSentData,
//         this.viewDraftData,
//     });

//     factory ViewMailResponse.fromJson(Map<String, dynamic> json) => ViewMailResponse(
//         mailThreadCount: json["mailThreadCount"],
//         totalUnread: json["totalUnread"],
//         viewInboxData: json["viewInboxResponseDTOS"] == null ? [] : List<ViewMailData>.from(json["viewInboxResponseDTOS"]!.map((x) => ViewMailData.fromJson(x))),
//         viewSentData: json["viewSentResponseDTOS"] == null ? [] : List<ViewMailData>.from(json["viewSentResponseDTOS"]!.map((x) => ViewMailData.fromJson(x))),
//         viewDraftData: json["viewDraftResponseDTOS"] == null ? [] : List<ViewMailData>.from(json["viewDraftResponseDTOS"]!.map((x) => ViewMailData.fromJson(x))),
//     );

//     @override
//       Map<String, dynamic> toJson() => {
//         "mailThreadCount": mailThreadCount,
//         "totalUnread": totalUnread,
//         "viewInboxResponseDTOS": viewInboxData == null ? [] : List<ViewMailData>.from(viewInboxData!.map((x) => x.toJson())),
//         "viewSentResponseDTOS": viewSentData == null ? [] : List<ViewMailData>.from(viewSentData!.map((x) => x.toJson())),
//         "viewDraftResponseDTOS": viewDraftData == null ? [] : List<ViewMailData>.from(viewDraftData!.map((x) => x.toJson())),
//     };
// }

// class ViewMailData {
//     final String? epicUserId;
//     final String? subject;
//     final String? requestType;
//     final String? createdUser;
//     final Uint8List? profileImage;
//     final int? inbox;
//     final int? inboxId;
//     final int? inboxReadStatus;
//     final int? mailThreadTotalUnread;
//     final List<MailResponseData>? mailResponseData;

//     ViewMailData({
//         this.epicUserId,
//         this.subject,
//         this.requestType,
//         this.createdUser,
//         this.profileImage,
//         this.inbox,
//         this.inboxId,
//         this.inboxReadStatus,
//         this.mailThreadTotalUnread,
//         this.mailResponseData,
//     });

//     factory ViewMailData.fromJson(Map<String, dynamic> json) => ViewMailData(
//         epicUserId: json["epicUserId"],
//         subject: json["subject"],
//         requestType: json["requestType"],
//         createdUser: json["createdUser"],
//         profileImage: AppUtils.decodeBase64(json["profileImage"]),
//         inbox: json["inbox"],
//         inboxId: json["inboxId"],
//         inboxReadStatus: json["inboxReadStatus"],
//         mailThreadTotalUnread: json["mailThreadTotalUnread"],
//         mailResponseData: json["mailResponseDTOList"] == null ? [] : List<MailResponseData>.from(json["mailResponseDTOList"]!.map((x) => MailResponseData.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "epicUserId": epicUserId,
//         "subject": subject,
//         "requestType": requestType,
//         "createdUser": createdUser,
//         "profileImage": profileImage,
//         "inbox": inbox,
//         "inboxId": inboxId,
//         "inboxReadStatus": inboxReadStatus,
//         "mailThreadTotalUnread": mailThreadTotalUnread,
//         "mailResponseDTOList": mailResponseData == null ? [] : List<MailResponseData>.from(mailResponseData!.map((x) => x.toJson())),
//     };
// }

// class MailResponseData {
//     final String? userName;
//     final int? msgId;
//     final String? message;
//     final DateTime? createdDate;
//     final int? readStatus;
//     final String? status;
//     final String? replyType;
//     final List<Attachment>? attachmentData;

//     MailResponseData({
//         this.userName,
//         this.msgId,
//         this.message,
//         this.createdDate,
//         this.readStatus,
//         this.status,
//         this.attachmentData,
//         this.replyType
//     });

//     factory MailResponseData.fromJson(Map<String, dynamic> json) => MailResponseData(
//         userName: json["userName"],
//         msgId:json["msgId"],
//         message: json["message"],
//         createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
//         readStatus: json["readStatus"],
//         status: json["status"],
//         replyType: json["replyType"],
//         attachmentData: json["attachmentRequestDTOList"] == null ? [] : List<Attachment>.from(json["attachmentRequestDTOList"]!.map((x) => Attachment.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "userName": userName,
//         "msgId":msgId,
//         "message": message,
//         "createdDate": createdDate?.toIso8601String(),
//         "readStatus": readStatus,
//         "status":status,
//         "replyType":replyType,
//         "attachmentRequestDTOList": attachmentData == null ? [] : List<Attachment>.from(attachmentData!.map((x) => x.toJson())),
//     };
// }

// class Attachment {
//     final String? attachment;
//     final String? attachmentName;
//     final String? attachmentType;

//     Attachment({
//         this.attachment,
//         this.attachmentName,
//         this.attachmentType,
//     });

//     factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
//         attachment: json["attachment"],
//         attachmentName: json["attachmentName"],
//         attachmentType: json["attachmentType"],
//     );

//     Map<String, dynamic> toJson() => {
//         "attachment": attachment,
//         "attachmentName": attachmentName,
//         "attachmentType": attachmentType,
//     };
// }

// To parse this JSON data, do
//
//     final viewMailResponse = viewMailResponseFromJson(jsonString);

// import 'dart:convert';

// import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

// ViewMailResponse viewMailResponseFromJson(String str) => ViewMailResponse.fromJson(json.decode(str));

// String viewMailResponseToJson(ViewMailResponse data) => json.encode(data.toJson());

// class ViewMailResponse extends Serializable{
//     final int? totalUnread;
//     final List<ViewMailData>? viewInboxResponseDtos;
//     final List<ViewMailData>? viewSentResponseDtos;
//     final List<ViewMailData>? viewDraftResponseDtos;

//     ViewMailResponse({
//         this.totalUnread,
//         this.viewInboxResponseDtos,
//         this.viewSentResponseDtos,
//         this.viewDraftResponseDtos,
//     });

//     factory ViewMailResponse.fromJson(Map<String, dynamic> json) => ViewMailResponse(
//         totalUnread: json["totalUnread"],
//         viewInboxResponseDtos: json["viewInboxResponseDTOS"] == null ? [] : List<ViewMailData>.from(json["viewInboxResponseDTOS"]!.map((x) => ViewMailData.fromJson(x))),
//         viewSentResponseDtos: json["viewSentResponseDTOS"] == null ? [] : List<ViewMailData>.from(json["viewSentResponseDTOS"]!.map((x) => ViewMailData.fromJson(x))),
//         viewDraftResponseDtos: json["viewDraftResponseDTOS"] == null ? [] : List<ViewMailData>.from(json["viewDraftResponseDTOS"]!.map((x) => ViewMailData.fromJson(x))),
//     );

//     @override
//       Map<String, dynamic> toJson() => {
//         "totalUnread": totalUnread,
//         "viewInboxResponseDTOS": viewInboxResponseDtos == null ? [] : List<dynamic>.from(viewInboxResponseDtos!.map((x) => x.toJson())),
//         "viewSentResponseDTOS": viewSentResponseDtos == null ? [] : List<dynamic>.from(viewSentResponseDtos!.map((x) => x.toJson())),
//         "viewDraftResponseDTOS": viewDraftResponseDtos == null ? [] : List<dynamic>.from(viewDraftResponseDtos!.map((x) => x.toJson())),
//     };
// }

// class ViewMailData {
//     final String? subject;
//     final String? createdUser;
//     final int? inbox;
//     final int? inboxId;
//     final int? inboxReadStatus;
//     final int? mailThreadTotalUnread;
//     final List<MailResponseData>? mailResponseDtoList;
//     final String? recipienctCategory;
//     final String? recipienctType;

//     ViewMailData({
//         this.subject,
//         this.createdUser,
//         this.inbox,
//         this.inboxId,
//         this.inboxReadStatus,
//         this.mailThreadTotalUnread,
//         this.mailResponseDtoList,
//         this.recipienctCategory,
//         this.recipienctType,
//     });

//     factory ViewMailData.fromJson(Map<String, dynamic> json) => ViewMailData(
//         subject: json["subject"],
//         createdUser: json["createdUser"],
//         inbox: json["inbox"],
//         inboxId: json["inboxId"],
//         inboxReadStatus: json["inboxReadStatus"],
//         mailThreadTotalUnread: json["mailThreadTotalUnread"],
//         mailResponseDtoList: json["mailResponseDTOList"] == null ? [] : List<MailResponseData>.from(json["mailResponseDTOList"]!.map((x) => MailResponseData.fromJson(x))),
//         recipienctCategory: json["recipienctCategory"],
//         recipienctType: json["recipienctType"],
//     );

//     Map<String, dynamic> toJson() => {
//         "subject": subject,
//         "createdUser": createdUser,
//         "inbox": inbox,
//         "inboxId": inboxId,
//         "inboxReadStatus": inboxReadStatus,
//         "mailThreadTotalUnread": mailThreadTotalUnread,
//         "mailResponseDTOList": mailResponseDtoList == null ? [] : List<dynamic>.from(mailResponseDtoList!.map((x) => x.toJson())),
//         "recipienctCategory": recipienctCategory,
//         "recipienctType": recipienctType,
//     };
// }

// class MailResponseData {
//     final int? msgId;
//     final String? userName;
//     final String? message;
//     final DateTime? createdDate;
//     final int? adminReadStatus;
//     final int? customerReadStatus;
//     final String? status;
//     final int? attachmentCount;

//     MailResponseData({
//         this.msgId,
//         this.userName,
//         this.message,
//         this.createdDate,
//         this.adminReadStatus,
//         this.customerReadStatus,
//         this.status,
//         this.attachmentCount,
//     });

//     factory MailResponseData.fromJson(Map<String, dynamic> json) => MailResponseData(
//         msgId: json["msgId"],
//         userName: json["userName"],
//         message: json["message"],
//         createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
//         adminReadStatus: json["adminReadStatus"],
//         customerReadStatus: json["customerReadStatus"],
//         status: json["status"],
//         attachmentCount: json["attachmentCount"],
//     );

//     Map<String, dynamic> toJson() => {
//         "msgId": msgId,
//         "userName": userName,
//         "message": message,
//         "createdDate": createdDate?.toIso8601String(),
//         "adminReadStatus": adminReadStatus,
//         "customerReadStatus": customerReadStatus,
//         "status": status,
//         "attachmentCount": attachmentCount,
//     };
// }



// To parse this JSON data, do
//
//     final viewMailResponse = viewMailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:union_bank_mobile/features/data/models/common/base_response.dart';

ViewMailResponse viewMailResponseFromJson(String str) => ViewMailResponse.fromJson(json.decode(str));

String viewMailResponseToJson(ViewMailResponse data) => json.encode(data.toJson());

class ViewMailResponse extends Serializable {
    final int? totalUnread;
    final int? inboxCount;
    final int? sentCount;
    final int? draftCount;
    final List<ViewMailData>? viewInboxResponseDtos;
    final List<ViewMailData>? viewSentResponseDtos;
    final List<ViewMailData>? viewDraftResponseDtos;

  ViewMailResponse({
    this.totalUnread,
    this.inboxCount,
    this.sentCount,
    this.draftCount,
    this.viewInboxResponseDtos,
    this.viewSentResponseDtos,
    this.viewDraftResponseDtos,
  });

    factory ViewMailResponse.fromJson(Map<String, dynamic> json) => ViewMailResponse(
        totalUnread: json["totalUnread"],
        inboxCount: json["inboxCount"],
        sentCount: json["sentCount"],
        draftCount: json["draftCount"],
        viewInboxResponseDtos: json["viewInboxResponseDTOS"] == null ? [] : List<ViewMailData>.from(json["viewInboxResponseDTOS"]!.map((x) => ViewMailData.fromJson(x))),
        viewSentResponseDtos: json["viewSentResponseDTOS"] == null ? [] : List<ViewMailData>.from(json["viewSentResponseDTOS"]!.map((x) => ViewMailData.fromJson(x))),
        viewDraftResponseDtos: json["viewDraftResponseDTOS"] == null ? [] : List<ViewMailData>.from(json["viewDraftResponseDTOS"]!.map((x) => ViewMailData.fromJson(x))),
    );

    @override
      Map<String, dynamic> toJson() => {
        "totalUnread": totalUnread,
        "inboxCount": inboxCount,
        "sentCount": sentCount,
        "draftCount": draftCount,
        "viewInboxResponseDTOS": viewInboxResponseDtos == null ? [] : List<dynamic>.from(viewInboxResponseDtos!.map((x) => x.toJson())),
        "viewSentResponseDTOS": viewSentResponseDtos == null ? [] : List<dynamic>.from(viewSentResponseDtos!.map((x) => x.toJson())),
        "viewDraftResponseDTOS": viewDraftResponseDtos == null ? [] : List<dynamic>.from(viewDraftResponseDtos!.map((x) => x.toJson())),
    };
}

class ViewMailData {
    final String? subject;
    final String? createdUser;
    final int? inbox;
    final int? inboxId;
    final int? inboxReadStatus;
    final int? mailThreadTotalUnread;
    final List<MailResponseData>? mailResponseDtoList;
    final String? recipientCategoryCode;
    final String? recipientCategoryName;
    final String? recipientTypeCode;
    final String? recipientTypeName;
    final String? recipientTypeEmail;
    final int? totalMessageCount;

    ViewMailData({
        this.subject,
        this.createdUser,
        this.inbox,
        this.inboxId,
        this.inboxReadStatus,
        this.mailThreadTotalUnread,
        this.mailResponseDtoList,
        this.recipientCategoryCode,
        this.recipientCategoryName,
        this.recipientTypeCode,
        this.recipientTypeName,
        this.recipientTypeEmail,
        this.totalMessageCount
    });

    factory ViewMailData.fromJson(Map<String, dynamic> json) => ViewMailData(
        subject: json["subject"],
        createdUser: json["createdUser"],
        inbox: json["inbox"],
        inboxId: json["inboxId"],
        inboxReadStatus: json["inboxReadStatus"],
        mailThreadTotalUnread: json["mailThreadTotalUnread"],
        mailResponseDtoList: json["mailResponseDTOList"] == null ? [] : List<MailResponseData>.from(json["mailResponseDTOList"]!.map((x) => MailResponseData.fromJson(x))),
        recipientCategoryCode: json["recipientCategoryCode"],
        recipientCategoryName: json["recipientCategoryName"],
        recipientTypeCode: json["recipientTypeCode"],
        recipientTypeName: json["recipientTypeName"],
        recipientTypeEmail: json["recipientTypeEmail"],
        totalMessageCount: json["totalMessageCount"],
    );

    Map<String, dynamic> toJson() => {
        "subject": subject,
        "createdUser": createdUser,
        "inbox": inbox,
        "inboxId": inboxId,
        "inboxReadStatus": inboxReadStatus,
        "mailThreadTotalUnread": mailThreadTotalUnread,
        "mailResponseDTOList": mailResponseDtoList == null ? [] : List<dynamic>.from(mailResponseDtoList!.map((x) => x.toJson())),
        "recipientCategoryCode": recipientCategoryCode,
        "recipientCategoryName": recipientCategoryName,
        "recipientTypeCode": recipientTypeCode,
        "recipientTypeName": recipientTypeName,
        "recipientTypeEmail": recipientTypeEmail,
        "totalMessageCount": totalMessageCount,
    };
}

class MailResponseData {
    final int? msgId;
    final String? userName;
    final String? message;
    final DateTime? createdDate;
    final int? adminReadStatus;
    final int? customerReadStatus;
    final String? status;
    final int? attachmentCount;

    MailResponseData({
        this.msgId,
        this.userName,
        this.message,
        this.createdDate,
        this.adminReadStatus,
        this.customerReadStatus,
        this.status,
        this.attachmentCount,
    });

    factory MailResponseData.fromJson(Map<String, dynamic> json) => MailResponseData(
        msgId: json["msgId"],
        userName: json["userName"],
        message: json["message"],
        createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
        adminReadStatus: json["adminReadStatus"],
        customerReadStatus: json["customerReadStatus"],
        status: json["status"],
        attachmentCount: json["attachmentCount"],
    );

    Map<String, dynamic> toJson() => {
        "msgId": msgId,
        "userName": userName,
        "message": message,
        "createdDate": createdDate?.toIso8601String(),
        "adminReadStatus": adminReadStatus,
        "customerReadStatus": customerReadStatus,
        "status": status,
        "attachmentCount": attachmentCount,
    };
}



