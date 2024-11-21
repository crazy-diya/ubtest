//
//  LankaQRPayload.swift
//  Runner
//
//  Created by Dimuthu Lakshan on 2023-03-06.
//

import Foundation

class LankaQRPayload: Encodable {
    internal init(qrMAIData: String? = nil, referenceId: String? = nil, transactionFee: String? = nil, convenienceFee: String? = nil, conveniencePercentage: Double? = nil, tipOrConFeeIndicator: String? = nil, merchantName: String? = nil, merchantCity: String? = nil, terminalId: String? = nil, billNumber: String? = nil, mobileNumber: String? = nil, storeId: String? = nil, loyaltyNumber: String? = nil, unrestrictedTag85String: String? = nil, pointOfInitiationMethod: String? = nil,merchantCategoryCode: String? = nil,consumerId:String? = nil, purpose:String? = nil) {
        self.qrMAIData = qrMAIData
        self.referenceId = referenceId
        self.transactionFee = transactionFee
        self.convenienceFee = convenienceFee
        self.conveniencePercentage = conveniencePercentage
        self.tipOrConFeeIndicator = tipOrConFeeIndicator
        self.merchantName = merchantName
        self.merchantCity = merchantCity
        self.terminalId = terminalId
        self.billNumber = billNumber
        self.mobileNumber = mobileNumber
        self.storeId = storeId
        self.loyaltyNumber = loyaltyNumber
        self.unrestrictedTag85String = unrestrictedTag85String
        self.pointOfInitiationMethod = pointOfInitiationMethod
        self.merchantCategoryCode = merchantCategoryCode
        self.consumerId = consumerId
        self.purpose = purpose
        
    }
    
    
    var qrMAIData: String?
    var referenceId: String?
    var transactionFee: String?
    var convenienceFee: String?
    var conveniencePercentage: Double?
    var tipOrConFeeIndicator: String?
    var merchantName: String?
    var merchantCity: String?
    var terminalId: String?
    var billNumber: String?
    var mobileNumber: String?
    var storeId: String?
    var loyaltyNumber: String?
    var unrestrictedTag85String: String?
    var pointOfInitiationMethod: String?
    var merchantCategoryCode: String?
    var consumerId: String?
    var purpose: String?
}
