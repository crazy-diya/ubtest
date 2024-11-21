//
//  JustPayCalls.swift
//  Runner
//
//  Created by Dimuthu-Lakshan on 2024-01-05.
//
import Foundation
import LPTrustedSDK

//import LCTrustedSDK

class ViewController: UIViewController, LPTrustedSDKDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        LPTrustedSDK().delegate = self
    }
    
    var lpTrustedSDK: LPTrustedSDK?
    var identityEventSuccess: (() -> Void)!
    var identityEventFailed: ((Int32, String) -> Void)!
    var onSignSuccess: ((String, String) -> Void)!
    var onSignFailed: ((Int32, String) -> Void)!
    
    func initJustPay() {
        
        if lpTrustedSDK == nil {
            lpTrustedSDK = LPTrustedSDK()
        }
        
        lpTrustedSDK?.delegate = self
    }
    //
    func isIdentityExist() -> Bool {
        return lpTrustedSDK?.isIdentityExist() ?? false
    }
    
    func getDeviceId() -> String {
        return lpTrustedSDK?.getDeviceId() ?? ""
    }
    //
    func createIdentity(challenge: String, identitySuccessCallback: (() -> Void)?, identityEventFailedCallback: ((Int32, String) -> Void)?) {
        self.identityEventSuccess = identitySuccessCallback
        self.identityEventFailed = identityEventFailedCallback
        lpTrustedSDK?.createIdentity(challenge)
        //        lcTrustedSDK?.createIdentity(challenge)
    }
    //
    func signMessage(message: String, signingSuccessCallback: ((String, String) -> Void)?, signingFailedCallback: ((Int32, String) -> Void)?){
        self.onSignSuccess = signingSuccessCallback
        self.onSignFailed = signingFailedCallback
        //        lcTrustedSDK?.signMessage(message)
        lpTrustedSDK?.signMessage(message)
//        LPTrustedSDK().signMessage(message)
    }
    //
    func revoke(){
        if lpTrustedSDK?.isIdentityExist() ?? false {
            lpTrustedSDK?.clearIdentity()
        }
    }
    //
    //    // Delegate Methods
    func onIdentitySuccess() {
        identityEventSuccess()
    }
    
    func onIdentityFailed(_ errorCode: Int32, message errorMessage: String!) {
        identityEventFailed(errorCode, errorMessage)
    }
    
    func onMessageSignSuccess(_ signedMessage: String!, status: String!) {
        onSignSuccess(signedMessage, status)
    }
    
    func onMessageSignFailed(_ errorCode: Int32, message errorMessage: String!) {
        onSignFailed(errorCode, errorMessage)
    }
}
