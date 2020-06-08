import Foundation

extension Bundle {
    enum InfoPlistKey: String {
        case versionNumber = "CFBundleShortVersionString"
        case buildNumber = "CFBundleVersion"
        case databaseSchemaVersion = "DatabaseSchemaVersion"
        case lastFmApiKey = "LastFmApiKey"
    }

    func plistValue<T>(for key: InfoPlistKey) -> T {
        guard let val = object(forInfoDictionaryKey: key.rawValue) as? T else {
            fatalError("Failed get \(type(of: T.self)) value for \(key.rawValue) key from info.plist")
        }
        return val
    }
}
