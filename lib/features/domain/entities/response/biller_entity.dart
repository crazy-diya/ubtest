import 'charee_code_entity.dart';
import 'custom_field_entity.dart';

class BillerEntity {
   // int? billerId;
   // String? billerCode;
   // String? billerName;// pay to acct name
   // String? billerImage;
   // String? description; // pay from name
   // String? displayName;
   // String? collectionAccount; //pay to acct nmbr
   // String? status;
   // ChargeCodeEntity? chargeCodeEntity;
   // List<CustomFieldEntity>? customFieldList;
  final int? billerId;
  final String? billerCode;
  late String? billerName;
  final String? billerImage;
  final String? description;
  final String? displayName;
  late String? collectionAccount;
  final String? status;
  final double? serviceChargeFlat;
  final String? serviceChargeType;
  final List<ServiceChargeRangeEntity>? serviceChargeRangeList;
  final ChargeCodeEntity? chargeCodeEntity;
  final List<CustomFieldEntity>? customFieldList;
  final String? referenceSample;
  final String? referencePattern;


  //janindu added
   String? startDate;
   String? endDate;
   String? frequency;
   String? noOfTransfers;
   String? payFromName;
   String? payFromNum;
   double? amount;
   int? scheduleID;
   String? statusDes;
   String? title;
  String? scheduleType;
  String? reference;
  String? tranType;
  String? fromBankCode;
  int? tabID;
  num? scheduleAmount;


  BillerEntity(
      {this.billerId,
      this.billerName,
      this.billerImage,
      this.billerCode,
      this.chargeCodeEntity,
      this.status,
      this.customFieldList,
      this.description,
      this.startDate,
      this.endDate,
      this.frequency,
      this.noOfTransfers,
      this.collectionAccount,
      this.payFromName,
      this.payFromNum,
      this.amount,
      this.scheduleID,
      this.statusDes,
      this.title,
      this.reference,
      this.displayName,
      this.scheduleType,
        this.serviceChargeFlat,
        this.serviceChargeRangeList,
        this.serviceChargeType,
        this.referencePattern,
        this.referenceSample,
        this.tabID,
        this.tranType,
        this.fromBankCode,
        this.scheduleAmount,
      });
}
