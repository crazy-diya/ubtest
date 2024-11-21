//
//  LankaQRGenerator.swift
//  Runner
//
//  Created by Dimuthu Lakshan on 2023-03-06.
//

import Foundation
import LankaQRUtilSDK
import MPQRCoreSDK

public class LankaQRGenerator{
    static let LQRGenErrorCode = "LQRGenError"
    
    static func generateQRCode(MCC: String, merchantName: String, merchantCity: String, bankCode: String, MID: String, TID: String, acquirerIIN: String, forwardingIIN: String) -> String {
        
        let pushPaymentData = PushPaymentData()
        do {
            //Tag 00 - Payload format indicator
            //                pushPaymentData.setPayloadFormatIndicator("01")
            pushPaymentData.payloadFormatIndicator = "01"
            
            //Tag 01 - Point of initiation method
            //                pushPaymentData.setValue("01", "11")
//            pushPaymentData.setValue("01", forKey: "11") Not working also
            pushPaymentData.pointOfInitiationMethod = "11"
            
            //                pushPaymentData.setMerchantIdentifierUnionPay15(acquirerIIN + forwardingIIN + MID)
            pushPaymentData.merchantIdentifierUNIONPAY15 = acquirerIIN+forwardingIIN+MID
            
            //Tag 26 - Merchant Identifier data
            let rootTag = "26"
            //            let maiData = MAIData(rootTag: rootTag)
            
            let maiData = MAIData()
            maiData.setRootTag(rootTag)
            //            maiData.setAID(generateMerchantIdentifierData(bankCode: bankCode, MID: MID, TID: TID)) //Generate by function
            maiData.AID = generateMerchantIdentifierData(bankCode: bankCode, MID: MID, TID: TID)
            try pushPaymentData.setDynamicMAIDTag(maiData)
            
            //Tag 52 - Merchant Category Code
            //                pushPaymentData.setMerchantCategoryCode(MCC)
            pushPaymentData.merchantCategoryCode = MCC
            
            //Tag 53 - Transaction Currency Code
            //                pushPaymentData.setTransactionCurrencyCode("144")
            pushPaymentData.transactionCurrencyCode = "144"
            
            //Tag 58 - Country Code
            //                pushPaymentData.setCountryCode("LK")
            pushPaymentData.countryCode = "LK"
            
            //Tag 59 - Merchant Name
            //                pushPaymentData.setMerchantName(merchantName)
            pushPaymentData.merchantName = merchantName
            
            //Tag 60 - Merchant City
            //                pushPaymentData.setMerchantCity(merchantCity)
            pushPaymentData.merchantCity = merchantCity
            
            //Tag 62  - Additional Data
            let additionalData = AdditionalData()
            //                additionalData.setTerminalId(TID)
            additionalData.terminalId = TID
            //                additionalData.setReferenceId("SmartPay")
            additionalData.referenceId = "SmartPay"
            //                pushPaymentData.setAdditionalData(additionalData)
            pushPaymentData.additionalData = additionalData
            
            //Tag 63 will be Auto generated
        } catch {
            return LQRGenErrorCode
        }
        
        do {
            //validate the payload before generate the QR code string
            //pushPaymentData.validate();
            let qrContent = try pushPaymentData.generatePushPaymentString()
            return qrContent
        } catch {
            return LQRGenErrorCode
        }
    }
    
    private static func generateMerchantIdentifierData(bankCode: String, MID: String, TID: String) -> String {
        var data = "1"
        data += bankCode
        data += "000"
        data += "0" + MID
        data += TID.suffix(4)
        
        return data
    }
}
