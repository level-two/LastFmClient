import RealmSwift

class DefaultDatabaseProvider: DatabaseProvider {
    var defaultRealm: Realm {
        do {
            return try Realm(configuration: defaultConfiguration)
        } catch {
            fatalError("Failed instantiate Realm: \(error)")
        }
    }

    fileprivate lazy var defaultConfiguration: Realm.Configuration = {
        var configuration = Realm.Configuration()
        configuration.schemaVersion = UInt64(Bundle.main.databaseSchemaVersion ?? 0)
        configuration.migrationBlock = self.performDatabaseMigration
        configuration.fileURL = configuration.fileURL?.replacingLastPathComponent("default.realm")
        return configuration
    }()

    fileprivate func performDatabaseMigration(_ migration: Migration, _ oldSchemaVersion: UInt64) {
        // For future use
    }
}
