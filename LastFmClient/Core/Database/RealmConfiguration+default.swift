import RealmSwift

extension Realm.Configuration {
    static func `default`() -> Realm.Configuration {
        var configuration = Realm.Configuration()
        configuration.schemaVersion = UInt64(Bundle.main.databaseSchemaVersion ?? 0)
        configuration.fileURL = configuration.fileURL?.replacingLastPathComponent("default.realm")
        return configuration
    }
}
