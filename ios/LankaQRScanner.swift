//
//  LankaQRScanner.swift
//  Runner
//
//  Created by Dimuthu Lakshan on 2023-03-06.
//

import Foundation
import LankaQRUtilSDK
import MPQRCoreSDK


public class LankaQRScanner{
    public static let LQRErrorCode = "LQRError"
    public static let InvalidLQR = "Invalid QR"
    
    public static func getLankaQRData(_ qrString: String) -> String?{
        let lankaQRReader = LankaQRReader()
        var qrdata : PushPaymentData?
        let lankaQRPayload = LankaQRPayload()
        var additionalData : AdditionalData?
        var unrestrictedData: UnrestrictedData?
        
        do{
            lankaQRReader.setLogging(logRequired: true)
            qrdata = lankaQRReader.parseQR(qrString: qrString)
            if(qrdata==nil){
                return LQRErrorCode
            }
            additionalData = qrdata?.additionalData
                        
            if let additionalData = additionalData {
                lankaQRPayload.referenceId = additionalData.referenceId != nil || additionalData.referenceId != "***" ? additionalData.referenceId! : ""
                lankaQRPayload.billNumber = additionalData.billNumber ?? ""
                lankaQRPayload.consumerId = additionalData.consumerId ?? ""
                lankaQRPayload.mobileNumber = additionalData.mobileNumber ?? ""
                lankaQRPayload.purpose = additionalData.purpose ?? ""
                lankaQRPayload.storeId = additionalData.storeId ?? ""
                lankaQRPayload.loyaltyNumber = additionalData.loyaltyNumber ?? ""
                lankaQRPayload.terminalId = additionalData.terminalId ?? ""
            }
        
            lankaQRPayload.merchantCategoryCode = qrdata?.merchantCategoryCode
            lankaQRPayload.pointOfInitiationMethod = qrdata?.pointOfInitiationMethod
            lankaQRPayload.transactionFee = qrdata?.transactionAmount ?? ""
            lankaQRPayload.merchantCity = qrdata?.merchantCity ?? ""
            lankaQRPayload.merchantName = qrdata?.merchantName ?? ""
            lankaQRPayload.tipOrConFeeIndicator = qrdata?.tipOrConvenienceIndicator ?? ""
            lankaQRPayload.convenienceFee = qrdata?.valueOfConvenienceFeeFixed ?? ""
            lankaQRPayload.conveniencePercentage = Double(qrdata?.valueOfConvenienceFeePercentage ?? "0") // nil comes check it
            
            do {
                if let ma26Data = try qrdata?.getMAIData(forTagString: "26") {
                    lankaQRPayload.qrMAIData = ma26Data.AID
                } else if let ma27Data = try qrdata?.getMAIData(forTagString: "27") {
                    lankaQRPayload.qrMAIData = ma27Data.AID
                }
            } catch {
            }
            
            //            try{
            //                unrestrictedData = qrdata.getUnrestrictedData("85");
            //                if(unrestrictedData != null){
            //                    lankaQRPayload.setUnrestrictedTag85String(unrestrictedData.toString());
            //                }
            //            }catch(Exception e){}
            
            do{
                try unrestrictedData = qrdata?.getUnreservedData(forTagString: "85") // check it again if got error *********
                if let unrestrictedData2 = unrestrictedData {
                    lankaQRPayload.unrestrictedTag85String = String(describing: unrestrictedData2)
                }
            }catch{
                
            }
            
            
            
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(lankaQRPayload)
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            } else {
                return "Failed to convert LankaQRPayload to JSON string"
            }
            
        }catch{
            return LQRErrorCode
        }
    }
}




//public class LankaQRScanner{
//    public static let LQRErrorCode = "LQRError"
//    public static let InvalidLQR = "Invalid QR"
//
//    public static func getLankaQRData(_ qrString: String) -> String?{
//        let lankaQRReader = LankaQRReader()
//        var pushPaymentData : PushPaymentData?
//        let lankaQRPayload = LankaQRPayload()
//        var additionalData : AdditionalData?
//        var unrestrictedData: UnrestrictedData?
//
//
//        do {
//            let qrdata : PushPaymentData?
//            qrdata = try parseQRCode(qrString)
//
//            additionalData = qrdata?.additionalData ?? AdditionalData()
//
//            lankaQRPayload.merchantCategoryCode = qrdata?.merchantCategoryCode
//            lankaQRPayload.pointOfInitiationMethod = qrdata?.pointOfInitiationMethod
//
//            if let additionalData = additionalData {
//                lankaQRPayload.referenceId = additionalData.referenceId != nil && additionalData.referenceId != "***" ? additionalData.referenceId! : ""
//                lankaQRPayload.billNumber = additionalData.billNumber ?? ""
//                lankaQRPayload.consumerId = additionalData.consumerId ?? ""
//                lankaQRPayload.mobileNumber = additionalData.mobileNumber ?? ""
//                lankaQRPayload.purpose = additionalData.purpose ?? ""
//                lankaQRPayload.storeId = additionalData.storeId ?? ""
//                lankaQRPayload.loyaltyNumber = additionalData.loyaltyNumber ?? ""
//                lankaQRPayload.terminalId = additionalData.terminalId ?? ""
//            }
//
//            lankaQRPayload.transactionFee = qrdata?.transactionAmount ?? ""
//            lankaQRPayload.merchantCity = qrdata?.merchantCity ?? ""
//            lankaQRPayload.merchantName = qrdata?.merchantName ?? ""
//            lankaQRPayload.tipOrConFeeIndicator = qrdata?.tipOrConvenienceIndicator ?? ""
//            lankaQRPayload.convenienceFee = qrdata?.valueOfConvenienceFeeFixed ?? ""
//            lankaQRPayload.conveniencePercentage = Double(qrdata?.valueOfConvenienceFeePercentage ?? "0") // nil comes check it
//
//            do {
//                if let ma26Data = try qrdata?.getMAIData(forTagString: "26") {
//                    lankaQRPayload.qrMAIData = ma26Data.AID
//                } else if let ma27Data = try qrdata?.getMAIData(forTagString: "27") {
//                    lankaQRPayload.qrMAIData = ma27Data.AID
//                }
//            } catch {}
//
//            //            try{
//            //                unrestrictedData = qrdata.getUnrestrictedData("85");
//            //                if(unrestrictedData != null){
//            //                    lankaQRPayload.setUnrestrictedTag85String(unrestrictedData.toString());
//            //                }
//            //            }catch(Exception e){}
//
//            do{
//                try unrestrictedData = qrdata?.getUnreservedData(forTagString: "85") // check it again if got error *********
//                if let unrestrictedData2 = unrestrictedData {
//                    lankaQRPayload.unrestrictedTag85String = String(describing: unrestrictedData2)
//                }
//            }catch{
//
//            }
//
//            // return try JSONEncoder().encode(lankaQRPayload) // implemented below all the code for this one
//
//            let jsonEncoder = JSONEncoder()
//            let jsonData = try jsonEncoder.encode(lankaQRPayload)
//
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                print(jsonString)
//                return jsonString
//            } else {
//                print("Failed to convert LankaQRPayload to JSON string")
//                return "Failed to convert LankaQRPayload to JSON string"
//            }
//
//        } catch {
//            return LQRErrorCode
//        }
//
//        //        lankaQRReader.setLogging(logRequired: false)
//        //
//        //        var result: String?
//        //
//        //        do{
//        //            pushPaymentData = try lankaQRReader.parseQR(qrString: qrString ) //  QR String
//        //            try result = pushPaymentData?.generatePushPaymentString()
//        //            print("-------------------- RESULT IN SWIFT EXAMPLE --------------------\n", result!)
//        //
//        //
//        //        }catch{
//        //
//        //        }
//
//    }
//
//    private static func parseQRCode(_ code: String) throws -> PushPaymentData? {
//        var qrcode: PushPaymentData?
//        do {
//            qrcode = try MPQRParser.parseWithoutTagValidation(code)
//            try qrcode?.validate()
//        } catch {}
//        return qrcode
//    }
//}
