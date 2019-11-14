import RealmSwift

class DefaultDatabaseProvider: DatabaseProvider {
    fileprivate var defaultRealm: Realm {
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

extension DefaultDatabaseProvider {
    func getAlbum(with albumId: String) -> AlbumDatabaseObject? {
        return self.defaultRealm
            .objects(AlbumDatabaseObject.self)
            .first(where: { $0.albumId == albumId })
    }

    func storeAlbum(_ album: AlbumDatabaseObject) {
        do {
            let realm = self.defaultRealm
            try realm.write { realm.add(album) }
        } catch {
            fatalError("Failed to store album to realm: \(error)")
        }
    }

    func getAlbumState(for albumId: String) -> AlbumStateDatabaseObject? {
        return self.defaultRealm
            .objects(AlbumStateDatabaseObject.self)
            .first(where: { $0.albumId == albumId })
    }

    func storeAlbumState(_ albumState: AlbumStateDatabaseObject) {
        do {
            let realm = self.defaultRealm
            try realm.write { realm.add(albumState) }
        } catch {
            fatalError("Failed to store album state to realm: \(error)")
        }
    }

    func isAlbumStored(albumId: String) -> Bool? {
        return getAlbumState(for: albumId)?.isStored
    }

    func setAlbumStored(albumId: String, stored: Bool) {
        do {
            let realm = self.defaultRealm

            let albumState = realm
                .objects(AlbumStateDatabaseObject.self)
                .first { $0.albumId == albumId }

            try realm.write { albumState?.isStored = stored }
        } catch {
            print("Failed to set album isStored state: \(error)")
        }
    }

    func onAlbumStateUpdate(albumId: String, callback: @escaping () -> Void) -> NotificationToken? {
        return self.defaultRealm
            .objects(AlbumStateDatabaseObject.self)
//            .first { $0.albumId == albumId }?
            .filter("albumId == '\(albumId)'")
            .observe { change in
                guard case .update(_, _, _, _) = change else { return }
                callback()
            }
    }
}
