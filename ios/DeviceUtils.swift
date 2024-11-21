

import Foundation

extension UIDevice {
    func installedAppIdentifiers() -> Set<String> {
        if let applications = Bundle(path: "/Applications")?.paths(forResourcesOfType: "app", inDirectory: nil) {
            return Set(applications.map { URL(fileURLWithPath: $0).deletingPathExtension().lastPathComponent })
        }
        return []
    }
}

func isTweakInstalled(bundleIdentifiers: [String]) -> Bool {
    let installedApps = UIDevice.current.installedAppIdentifiers()
    let tweakIdentifiers = Set(bundleIdentifiers)
    return !installedApps.isDisjoint(with: tweakIdentifiers)
}


