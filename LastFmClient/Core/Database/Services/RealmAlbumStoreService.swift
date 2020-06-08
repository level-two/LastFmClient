import RealmSwift
import RxSwift

class RealmAlbumStoreService: AlbumStoreService {
    func storeAlbum(_ album: Album) {
        do {
            let realm = Realm.default
            let albumObject = AlbumObject(from: album)
            try realm.write { realm.add(albumObject) }
        } catch {
            fatalError("Failed to store album to realm: \(error)")
        }
    }

    func removeAlbum(with mbid: String) {
        do {
            let realm = Realm.default
            guard let albumObject = realm.objects(AlbumObject.self).first(where: { $0.mbid == mbid }) else { return }
            try realm.write { realm.delete(albumObject) }
        } catch {
            fatalError("Failed to store album to realm: \(error)")
        }
    }

    func getAlbum(with mbid: String) -> Album? {
        return Realm.default
            .objects(AlbumObject.self)
            .first { $0.mbid == mbid }
    }

    func isAlbumStored(with mbid: String) -> Bool {
        return Realm.default
            .objects(AlbumObject.self)
            .contains { $0.mbid == mbid }
    }

    func onAlbumStoredStateChange(with mbid: String) -> Observable<Bool> {
        return Realm.default
            .objects(AlbumObject.self)
            .filter("mbid == '\(mbid)'")
            .asObservable
            .map { !$0.isEmpty }
    }
}
