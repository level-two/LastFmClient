import Foundation

extension Bundle {
    var versionNumber: String? {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    var buildNumber: String? {
        return object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }

    var databaseSchemaVersion: Int? {
        return object(forInfoDictionaryKey: "DatabaseSchemaVersion") as? Int
    }

    // FIXME: this should be moved to the AppDefaults or AppSettings
    var lastFmApiKey: String? {
        return object(forInfoDictionaryKey: "LastFmApiKey") as? String
    }
}
