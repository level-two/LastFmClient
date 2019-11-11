import UIKit
import RealmSwift

class AlbumDetailsModelController {
    fileprivate let networkService: NetworkService
    fileprivate let databaseProvider: DatabaseProvider

    init(networkService: NetworkService, databaseProvider: DatabaseProvider) {
        self.networkService = networkService
        self.databaseProvider = databaseProvider
    }

    func request(albumId: String, completion: @escaping (AlbumDetailsModel?, Error?) -> Void) {
        let albums = databaseProvider.defaultRealm.objects(AlbumDatabaseObject.self)

        if let albumObject = albums.first(where: { $0.albumId == albumId }) {
            networkService.getImage(albumObject.mediumImageUrl) { image in
                var albumModel = AlbumDetailsModel(from: albumObject)
                albumModel.coverImage = image
                completion(albumModel, nil)
            }
        } else {
            networkService.album.getInfo(albumId: albumId) { [weak self] response in
                guard let self = self else { return }
                do {
                    // FIXME: Handle errors
                    let albumObject = AlbumDatabaseObject(from: response)
                    let realm = self.databaseProvider.defaultRealm

                    try realm.write {
                        realm.add(albumObject)
                    }

                    self.networkService.getImage(albumObject.mediumImageUrl) { image in
                        var albumModel = AlbumDetailsModel(from: albumObject)
                        albumModel.coverImage = image
                        completion(albumModel, nil)
                    }
                } catch {
                    return completion(nil, error)
                }
            }
        }
    }
}

extension AlbumDatabaseObject {
    convenience init(from albumInfoResponse: NetworkService.Album.AlbumInfoResponse) {
        self.init()

        self.albumId = albumInfoResponse.albumId
        self.name = albumInfoResponse.name
        self.artist = albumInfoResponse.artist
        self.mediumImageUrl = albumInfoResponse.mediumImageUrl

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd MM yyyy, HH:mm"
        self.releaseDate = dateFormatter.date(from: albumInfoResponse.releaseDate)

        let trackObjects = albumInfoResponse.tracks.map(TrackDatabaseObject.init)
        self.tracks = List<TrackDatabaseObject>()
        self.tracks.append(objectsIn: trackObjects)
    }
}

extension TrackDatabaseObject {
    convenience init(from trackInfoResponse: NetworkService.Album.TrackInfoResponse) {
        self.init()

        self.rank = trackInfoResponse.rank
        self.name = trackInfoResponse.name
        self.artist = trackInfoResponse.artist
        self.duration = trackInfoResponse.duration
    }
}
