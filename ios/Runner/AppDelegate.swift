import UIKit
import Flutter
import Firebase
import FirebaseMessaging
import FirebaseCore
import flutter_local_notifications
import GoogleMaps
import IOSSecuritySuite

import Foundation
import MachO
import CommonCrypto
import app_links

@main
@objc class AppDelegate: FlutterAppDelegate {

    let jailbreakTweaks = ["com.ryleyangus.liberty",
                           "com.ryleyangus.libertylite",
                           "com.ryleyangus.libertylite.beta",
                           "com.rpgfarm.a-bypass",
                           "jp.akusio.kernbypass",
                           "com.apple.memecity",
                           "jp.akusio.kernbypass-unofficial",
                           "kr.xsf1re.flyjbx",
                           "kr.xsf1re.flyjb",
                           "com.julioverne.jailprotect",
                           "com.kc57.ihide",
                           "com.icraze.hestia",
                           "com.hackyouriphone.hestia",
                           "com.sinfooldev.hestia",
                           "com.thebigboss.hestia"]

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
            GeneratedPluginRegistrant.register(with: registry)
        }
        FirebaseApp.configure()
        application.registerForRemoteNotifications()

        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
        }

        var chekJBR = false;
        var chekJBR1 = false;
        
        let justpayCalls = ViewController()
        justpayCalls.initJustPay()
        GMSServices.provideAPIKey("AIzaSyAJJdCqJDR5aYYY3Unv4K2wwcMkKcdzbEA")


        //Security Check
        if IOSSecuritySuite.amIJailbroken() {
            chekJBR1 = true;
        } else {
            chekJBR1 = false;
            print("This device is not jailbroken")
        }
        
        
        if isTweakInstalled(bundleIdentifiers: jailbreakTweaks) {
            print("Jailbreak and Cydia tweaks detected!")
            chekJBR = true
            // Handle detection here (e.g., prevent running sensitive operations)
        } else {
            print("Jailbreak detected but no Cydia tweaks found.")
            chekJBR = false
            // Proceed with normal app flow
        }
        
        let channelName = "ubgo_method_channel"
        let rootViewController : FlutterViewController = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: rootViewController as! FlutterBinaryMessenger)
        
        methodChannel.setMethodCallHandler {(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
             
             // Security - Jailbreak
             if(call.method == "3f67a8a2"){
                let isJailbroken = SecureCheck.isJailbroken()
                
                if ( isJailbroken || chekJBR || chekJBR1 ||
                     (TARGET_IPHONE_SIMULATOR == 1) ||
                     isInjectedWithDynamicLibrary() ||
                     isJb() ||
                     IOSSecuritySuite.amIJailbroken() ||
                     IOSSecuritySuite.amIProxied() ||
                     IOSSecuritySuite.amIReverseEngineered() ||
                     SecureCheck.isJailBrokenNew()
                     ||
                     SecureCheck.checkJBKalana()
                     ||
                     UIDevice.isAppContainUnAuthorizedApps()
                     ||
                     UIDevice.isAppCanEditSystemFiles()
                     ||
                     UIDevice.isAppCanOpenUnAuthorizedURL()
                     ||
//                     UIDevice.isInvalidProvisioningProfile()
//                     ||
                     UIDevice.isAppContainUnAuthorizedFiles()
                     ||
                     UIDevice.isSystemAPIAccessable()
                ){

                    result(true)
                } else{
                    result(false)
                }
            }
            // JustPay
            if (call.method == "2b34675e") {
                
                let deviceID = justpayCalls.getDeviceId()
                
                if !deviceID.isEmpty {
                    
                    result(deviceID)
                    
                } else {
                    
                    result("null")
                }
                
            }
            // Screen Shot Disable
            else if(call.method == "917ca3f0"){
                 self.window.makeSecure()
            }
            
            else if call.method == "9a479f83" {
                
                result(justpayCalls.isIdentityExist())
            }
            
            else if call.method == "78fd1637" {
                justpayCalls.revoke()
                
            }
            
            else if (call.method == "80dcbec1") {
                print("Recived");
                if let args = call.arguments as? Dictionary<String, Any> {
                    if let challenge = args["challenge"] as? String {
                        justpayCalls.createIdentity(challenge: challenge, identitySuccessCallback: {
                            print("input create identeity part");
                            let response = JustPayResponse(isSuccess: true, data: true.description, code: 0)
                            do {
                                let jsonData = try JSONEncoder().encode(response)
                                let jsonString = String(data: jsonData, encoding: .utf8)!
                                print(jsonString)
                                result(jsonString)
                            } catch { print(error) }
                        }, identityEventFailedCallback: { (errorCode, message) in
                            let response = JustPayResponse(isSuccess: false, data: "CODE : \(errorCode) ERROR : \(message)", code: 0)
                            do {
                                let jsonData = try JSONEncoder().encode(response)
                                let jsonString = String(data: jsonData, encoding: .utf8)!
                                print(jsonString)
                                result(jsonString)
                            } catch { print(error) }
                        })
                    }
                }
                
            }
            
            else if (call.method == "cc658593") {
                
                if let args = call.arguments as? Dictionary<String, Any> {
                    if let message = args["terms"] as? String {
                        justpayCalls.signMessage(message: message) { (signedMessage, status) in
                            let response = JustPayResponse(isSuccess: true, data: signedMessage, code: 0)
                            do {
                                let jsonData = try JSONEncoder().encode(response)
                                let jsonString = String(data: jsonData, encoding: .utf8)!
                                print(jsonString)
                                result(jsonString)
                            } catch { print(error) }
                        } signingFailedCallback: { (errorCode, message) in
                            let response = JustPayResponse(isSuccess: false, data: "CODE : \(errorCode) ERROR : \(message)", code: 0)
                            do {
                                let jsonData = try JSONEncoder().encode(response)
                                let jsonString = String(data: jsonData, encoding: .utf8)!
                                print(jsonString)
                                result(jsonString)
                            } catch { print(error) }
                        }
                    }
                }
                
            }
            
            // LankaQR
            else if(call.method ==  "2ef6f68d"){
                if let args = call.arguments as? Dictionary<String, Any> {
                    if let qrString = args["qrString"] as? String {
                        let lankaQR = LankaQRScanner.getLankaQRData(qrString)
                        if(lankaQR == LankaQRScanner.LQRErrorCode){
                            result(FlutterError(code: LankaQRScanner.LQRErrorCode, message: LankaQRScanner.InvalidLQR, details: LankaQRScanner.InvalidLQR))
                        }else{
                            result(lankaQR)
                        }
                    }
                }
            }
            
            else if(call.method == "f6a380f7"){
                if let args = call.arguments as? [String: Any], let mcc = args["mcc"] as? String, let merchantName = args["merchantName"] as? String, let merchantCity = args["merchantCity"] as? String, let bankCode = args["bankCode"] as? String, let mid = args["mid"] as? String, let tid = args["tid"] as? String, let acquirerIIN = args["acquirerIIN"] as? String, let forwardingIIN = args["forwardingIIN"] as? String {
                    
                    let lankaQR = LankaQRGenerator.generateQRCode(MCC: mcc, merchantName: merchantName, merchantCity: merchantCity, bankCode: bankCode, MID: mid, TID: tid, acquirerIIN: acquirerIIN, forwardingIIN: forwardingIIN)
                    
                    if lankaQR == LankaQRGenerator.LQRGenErrorCode {
                        result(FlutterError(code: LankaQRGenerator.LQRGenErrorCode, message: LankaQRGenerator.LQRGenErrorCode, details: LankaQRGenerator.LQRGenErrorCode))
                    } else {
                        result(lankaQR)
                    }
                }
            }
            
            
        }
        
        GeneratedPluginRegistrant.register(with: self)

        //DeepLinking
         if let url = AppLinks.shared.getLink(launchOptions: launchOptions) {
            AppLinks.shared.handleLink(url: url)
            return true 
        }
        //------------------------------------------//

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}



extension UIWindow {
func makeSecure() {
        let field = UITextField()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: field.frame.self.width, height: field.frame.self.height))
        field.isSecureTextEntry = true
        self.addSubview(field)
        self.layer.superlayer?.addSublayer(field.layer)
        field.layer.sublayers?.last!.addSublayer(self.layer)
        field.leftView = view
        field.leftViewMode = .always
    }
   }
