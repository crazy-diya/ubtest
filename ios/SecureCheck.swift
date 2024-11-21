
import Foundation

class SecureCheck {
    class func isJailbroken() -> Bool {
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: "/Applications/Cydia.app") ||
            fileManager.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
            fileManager.fileExists(atPath: "/bin/bash") ||
            fileManager.fileExists(atPath: "/usr/sbin/sshd") ||
            fileManager.fileExists(atPath: "/etc/apt") ||
            fileManager.fileExists(atPath: "/usr/bin/ssh") ||
            fileManager.fileExists(atPath: "/private/var/stash") ||
            fileManager.fileExists(atPath: "/private/var/tmr/stash") ||
            fileManager.fileExists(atPath: "/private/var/lib/cydiar/stash") ||
            fileManager.fileExists(atPath: "/private/var/mobile/Library/SBr/stash") ||
            fileManager.fileExists(atPath: "/Library/MobileSubstratr/stash") ||
            fileManager.fileExists(atPath: "/Library/MobileSubstrate/DynamicLibrr/stash") ||
            fileManager.fileExists(atPath: "/Library/MobileSubstrate/DynamicLibrarr/stash") ||
            fileManager.fileExists(atPath: "/System/Library/LaunchDaemonr/stash") ||
            fileManager.fileExists(atPath: "/System/Library/LaunchDaemons/com.sar/stash") ||
            fileManager.fileExists(atPath: "/var/car/stash") ||
            fileManager.fileExists(atPath: "/var/lor/stash") ||
            fileManager.fileExists(atPath: "/var/tmr/stash") ||
            fileManager.fileExists(atPath: "/bin/bashr/stash") ||
            fileManager.fileExists(atPath: "/bin/shr/stash") ||
            fileManager.fileExists(atPath: "/usr/sr/stash") ||
            fileManager.fileExists(atPath: "/usr/liber/stash") ||
            fileManager.fileExists(atPath: "/usr/bir/stash") ||
            fileManager.fileExists(atPath: "/usr/libexer/stash") ||
            fileManager.fileExists(atPath: "/etc/ssr/stash") ||
            fileManager.fileExists(atPath: "/etr/stash") ||
            fileManager.fileExists(atPath: "/private/var/lib/apt/") {
            return true
        }
        
        if let cydiaURL = URL(string: "cydia://package/com.example.package") {
            if fileManager.fileExists(atPath: cydiaURL.path) {
                return true
            }
        }
        
        return false
    }
    
    //Check whether the device is jail broken
        static func isJailBrokenNew() -> Bool{
            if TARGET_IPHONE_SIMULATOR != 1
            {
                // Check 1 : existence of files that are common for jailbroken devices
                if FileManager.default.fileExists(atPath: "/Applications/Cydia.app")
                    || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
                    || FileManager.default.fileExists(atPath: "/bin/bash")
                    || FileManager.default.fileExists(atPath: "/usr/sbin/sshd")
                    || FileManager.default.fileExists(atPath: "/etc/apt")
                    || FileManager.default.fileExists(atPath: "/private/var/lib/apt/")
                    || UIApplication.shared.canOpenURL(URL(string:"cydia://package/com.example.package")!)
                    || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
                    || FileManager.default.fileExists(atPath: "/bin/bash")
                    || FileManager.default.fileExists(atPath: "/usr/sbin/sshd")
                    || FileManager.default.fileExists(atPath: "/etc/apt")
                    || FileManager.default.fileExists(atPath: "/private/var/lib/apt/")
                    || FileManager.default.fileExists(atPath: "/private/var/lib/stash")
                    || FileManager.default.fileExists(atPath: "/private/var/tmp/cydia.log")
                    || FileManager.default.fileExists(atPath: "/private/var/lib/cydia")
                    || FileManager.default.fileExists(atPath: "/private/var/mobile/Library/SBSettings/Themes")
                    || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
                    || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/DynamicLibraries/Veency.plist")
                    || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist")
                    || FileManager.default.fileExists(atPath: "/System/Library/LaunchDaemons/com.ikey.bbot.plist")
                    || FileManager.default.fileExists(atPath: "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist")
                    || FileManager.default.fileExists(atPath: "/var/cache/apt")
                    || FileManager.default.fileExists(atPath: "/var/lib/apt")
                    || FileManager.default.fileExists(atPath: "/var/lib/cydia")
                    || FileManager.default.fileExists(atPath: "/var/log/syslog")
                    || FileManager.default.fileExists(atPath: "/var/tmp/cydia.log")
                    || FileManager.default.fileExists(atPath: "/bin/bash")
                    || FileManager.default.fileExists(atPath: "/bin/sh")
                    || FileManager.default.fileExists(atPath: "/usr/libexec/ssh-keysign")
                    || FileManager.default.fileExists(atPath: "/usr/bin/sshd")
                    || FileManager.default.fileExists(atPath: "/usr/libexec/sftp-server")
                    || FileManager.default.fileExists(atPath: "/etc/ssh/sshd_config")
                    || FileManager.default.fileExists(atPath: "/Applications/RockApp.app")
                    || FileManager.default.fileExists(atPath: "/Applications/Icy.app")
                    || FileManager.default.fileExists(atPath: "/Applications/WinterBoard.app")
                    || FileManager.default.fileExists(atPath: "/Applications/SBSettings.app")
                    || FileManager.default.fileExists(atPath: "/Applications/MxTube.app")
                    || FileManager.default.fileExists(atPath: "/Applications/IntelliScreen.app")
                    || FileManager.default.fileExists(atPath: "/Applications/FakeCarrier.app")
                    || FileManager.default.fileExists(atPath: "/Applications/blackra1n.app")
                    || FileManager.default.fileExists(atPath: "/Library/TweakInject")
                    || FileManager.default.fileExists(atPath: "/Applications/Sileo.app")
                    || FileManager.default.fileExists(atPath: "/usr/libexec/sileo")
                    || FileManager.default.fileExists(atPath: "/etc/apt/sources.list.d/sileo.sources")
                    || UIApplication.shared.canOpenURL(URL(string:"cydia://package/com.example.package")!)
                    || UIApplication.shared.canOpenURL(URL(string:"sileo://package/com.example.package")!)
                {
                    return true
                }
                // Check 2 : Reading and writing in system directories (sandbox violation)
                let stringToWrite = "Jailbreak Test"
                do
                {
                    try stringToWrite.write(toFile:"/private/JailbreakTest.txt", atomically:true, encoding:String.Encoding.utf8)
                    //Device is jailbroken
                    return true
                }catch
                {
                    return false
                }
            } else {
                return false
            }
        }
       
        //kalana's functions
       
        static func checkJBKalana() -> Bool{
            var isJbyes = false
           
            if (sim()  == "JBroken" || jbPath() == "JBroken" || slPath() == "JBroken" || dyLibName() == "JBroken" || checkPkgManager() == "JBroken"){
                isJbyes = true
            }else{
                isJbyes = false
            }
           
            return isJbyes
        }
        //check for simulator
        static func sim() -> String {
            #if targetEnvironment(simulator)
            return "JBroken"
            #else
            return "notJBroken"
            #endif
        }

        // Check for known jailbreak-related files, directories, and binaries
        static func jbPath() -> String {
            let fm = FileManager.default
            let jbPaths = [
                "/Applications/Cydia.app",
                "/usr/libexec/cydia",
                "/Applications/Sileo.app",
                "/usr/libexec/sileo",
                "/etc/apt",
                "/private/var/lib/cydia",
                "/../../../../bin/bash",
                "/usr/sbin/sshd",
                "/usr/bin/sshd",
                "/usr/bin/ssh",
                "/Library/MobileSubstrate/MobileSubstrate.dylib",
                "/private/var/lib/apt",
                "/private/var/tmp/cydia.log",
                "/Applications/WinterBoard.app",
                "/var/lib/cydia",
                "/private/etc/dpkg/origins/debian",
                "/bin.sh",
                "/private/etc/apt",
                "/etc/ssh/sshd_config",
                "/private/etc/ssh/sshd_config",
                "/Applications/SBSetttings.app",
                "/private/var/mobileLibrary/SBSettingsThemes/",
                "/private/var/stash",
                "/usr/libexec/sftp-server",
                "/usr/sbin/frida-server",
                "/usr/bin/cycript",
                "/usr/local/bin/cycript",
                "/usr/lib/libcycript.dylib",
                "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
                "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
                "/Applications/FakeCarrier.app",
                "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
                "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
                "/usr/libexec/ssh-keysign",
                "/Applications/blackra1n.app",
                "/Applications/IntelliScreen.app",
                "/Applications/Snoop-itConfig.app",
                "/var/checkra1n.dmg",
                "/var/binpack",
                "/Applications/Icy.app",
                "/Applications/IntelliScreen.app",
                "/Applications/MxTube.app",
                "/Applications/RockApp.app",
                "/bin/sh",
                "/bin/su",
                "/pguntether",
                "/private/var/mobile/Library/SBSettings/Themes",
                "/var/cache/apt",
                "/var/log/syslog",
                "/var/mobile/Media/.evasi0n7_installed",
                "/var/tmp/cydia.log",
                "/cores/jbinit.log",
                "/cores/fake",
                "/var/jb/Library/LaunchDaemons",
                "/var/jb/etc/rc.d",
                "/cores/jbloader",
                "/cores/jbinit.log",
                "/cores/fs/fake",
                "/cores/fs/real",
                "/cores/binpack/Applications/palera1nLoader.app",
                "/var/jb/etc/rc.d",
                "/var/jb/Library/LaunchDaemons"
            ]

            for path in jbPaths {
                if fm.fileExists(atPath: path) {
                    return "JBroken"
                }
            }
            return "notJBroken"
        }

        // Check for symbolic links
        static func slPath() -> String {
            let fm = FileManager.default
            let slPaths = [
                "/Applications",
                "/var/stash/Library/Ringtones",
                "/var/stash/Library/Wallpaper",
                "/var/stash/usr/include",
                "/var/stash/usr/libexec",
                "/var/stash/usr/share",
                "/var/stash/usr/arm-apple-darwin9",
                "/Library/MobileSubstrate/DynamicLibraries"
            ]

            for linkPath in slPaths {
                if fm.fileExists(atPath: linkPath, isDirectory: nil) {
                    let attributes = try? fm.attributesOfItem(atPath: linkPath)
                    if attributes?[FileAttributeKey.type] as! String == FileAttributeType.typeSymbolicLink.rawValue {
                        return "JBroken"
                    }
                }
            }
            return "notJBroken"
        }

        // Check for Dynamic links
        static func dyLibName() -> String {
            let dyLibNames = [
                "cyinject",
                "libcycript",
                "FridaGadget",
                "zzzzLiberty.dylib",
                "SSLCertificatePinningBypass2.dylib",
                "0Shadow.dylib",
                "MobileSubstrate.dylib",
                "libsparkapplist.dylib",
                "SubstrateInserter.dylib",
                "zzzzzzUnSub.dylib",
                "...!@#",
                "/usr/lib/Cephei.framework/Cephei"
            ]

            for dyLibName in dyLibNames {
                if dlopen(dyLibName, RTLD_LAZY) != nil {
                    return "JBroken"
                }
            }
            return "notJBroken"
        }

        //check for JB package managers
        static func checkPkgManager() -> String {
            let pkgManagerURLs = [
                "cydia://package/com.example.package",
                "sileo://package/com.example.package",
                "zbra://package/com.example.package",
                "installer://package/com.example.package",
                "rockapp://package/com.example.package",
                "icy://package/com.example.package",
                "saily://package/com.example.package",
                "packix://package/com.example.package",
                "undecimus://package/com.example.package",
                "xina://package/com.example.package",
                "filza://package/com.example.package",
                "santander://package/com.example.package",
                "apt-repo://package/com.example.package"
            ]
       
            for url in pkgManagerURLs {
                if let packageURL = URL(string: url), UIApplication.shared.canOpenURL(packageURL) {
                    return "JBroken"
                }
            }
            return "notJBroken"
        }

    
}
