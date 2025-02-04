
import UIKit
import IOSSecuritySuite



/// This extension helps in adding certain ways to detect jailbroken devices

extension UIDevice {

    

    static let isSimulator: Bool = {

        var isSim = false

        #if targetEnvironment(simulator)

        isSim = true

        #endif

        return isSim

    }()

    

    /// List of unauthorized apps path

    static var unAuthorizedApps: [String] {

        let appsList = ["/Applications/Cydia.app",

                        "/Applications/FakeCarrier.app",

                        "/Applications/Icy.app",

                        "/Applications/MxTube.app",

                        "/Applications/IntelliScreen.app",

                        "/Applications/RockApp.app",

                        "/Applications/WinterBoard.app",

                        "/Applications/SBSettings.app",

                        "/Applications/blackra1n.app"

        ]

        return appsList

    }

    

    /// List of unauthorized file paths

    static var unAuthorizedFiles: [String] {

        let filesList = ["/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",

                         "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",

                         "/Library/MobileSubstrate/MobileSubstrate.dylib",

                         "/System/Library/LaunchDaemons/com.ikey.bbot.plist",

                         "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",

                         "/bin/bash",

                         "/bin/sh",

                         "/etc/apt",

                         "/etc/ssh/sshd_config",

                         "/private/var/lib/apt",

                         "/private/var/lib/apt/",

                         "/private/var/lib/cydia",

                         "/private/var/mobile/Library/SBSettings/Themes",

                         "/private/var/stash",

                         "/private/var/tmp/cydia.log",

                         "/usr/bin/sshd",

                         "/usr/libexec/sftp-server",

                         "/usr/libexec/ssh-keysign",

                         "/usr/sbin/sshd",

                         "/var/cache/apt",

                         "/var/lib/apt",

                         "/var/lib/cydia",

                         "/Library/Frameworks/CydiaSubstrate.framework",

                         "/Library/MobileSubstrate",

                         "/Library/MobileSubstrate/DynamicLibraries",

                         "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",

                         "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",

                         "/Library/MobileSubstrate/MobileSubstrate.dylib",

                         "/Library/MobileSubstrateMobileSubstrate.dylib",

                         "/var/mobile/Library/Preferences/com.ryleyangus.libertylite.plist"]

        

        return filesList

    }

    

    /// Check if the app can open a Cydia's URL scheme

    static func isAppCanOpenUnAuthorizedURL() -> Bool {

        if let url = URL(string: "cydia://"),

            UIApplication.shared.canOpenURL(url) {

            return true

        }

        return false

    }

    

    /// Check if the app have permission to write outside of its sandbox

    static func isAppCanEditSystemFiles() -> Bool {

        

        let stringToWrite = "epic text"

        let filePath = "/private/epic.txt"

        do {

            try stringToWrite.write(toFile: filePath, atomically: true, encoding: .utf8)

            return true

        } catch {

            return false

        }

    }

    

    /// Check if device able to access system API's

    static func isSystemAPIAccessable() -> Bool {

        var pid: pid_t = -1

        var status: Int32

        status = posix_spawn(&pid, "", nil, nil, [], nil)

        waitpid(pid, &status, WEXITED)

        return pid >= 0

    }

    

    /// Function to check if device contains unauthorized apps

    static func isAppContainUnAuthorizedApps()-> Bool {

        for filePath in unAuthorizedApps {

            if FileManager.default.fileExists(atPath: filePath) {

                return true

            }

        }

        return false

    }

    

    /// Function to check if device contains unauthorized files

    static func isAppContainUnAuthorizedFiles() -> Bool {

        for filePath in unAuthorizedFiles {

            if FileManager.default.fileExists(atPath: filePath) {

                return true

            }

        }

        return false

    }

///temper ditection
    static func isInvalidProvisioningProfile()->Bool{
            let data1 = "bGsuY2RiLmRpZ2l0YWxiYW5raW5n"
            let data2 = "YTA1NGMwMTIwZjg0ZTcyMDFkZTQ0ZDAwZjkwZDk5NzNmMzQ5OWQwZGZiNDFhNWQyMzY5OGY5Mjc0YzQ1MGVkYg=="
            
            if IOSSecuritySuite.amITampered([.bundleID(decodeBase64Value(of: data1)), .mobileProvision(decodeBase64Value(of: data2))]).result {
                return true
            } else {
                return false
            }
        }
    static func decodeBase64Value(of base64Encoded: String)->String{
            var decodedString = ""
            if let decodedData = Data(base64Encoded: base64Encoded) {
                decodedString = String(data: decodedData, encoding: .utf8)!
            }

            if !decodedString.isEmpty {
                return decodedString
            } else {
                return ""
            }
        }
}
