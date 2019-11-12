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

        if let albumObject = albums.first(where: { $0.albumId == albumId }),
            let imageUrl = albumObject.mediumImageUrl {

            networkService.getImage(imageUrl) { image in
                var albumModel = AlbumDetailsModel(from: albumObject)
                albumModel.coverImage = image
                completion(albumModel, nil)
            }

        } else {
            LastFmClient().getAlbumDetails(from: .info(albumId: albumId)) { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .failure(let error):
                    completion(nil, error)
                case .success(let albumDetails):
                    do {
                        let albumObject = AlbumDatabaseObject(from: albumDetails)
                        let realm = self.databaseProvider.defaultRealm

                        try realm.write {
                            realm.add(albumObject)
                        }

                        if let imageUrl = albumObject.mediumImageUrl {
                            self.networkService.getImage(imageUrl) { image in
                                var albumModel = AlbumDetailsModel(from: albumObject)
                                albumModel.coverImage = image
                                completion(albumModel, nil)
                            }
                        }
                    } catch {
                        completion(nil, error)
                    }
                }
            }
        }
    }
}

extension AlbumDatabaseObject {
    convenience init(from albumInfoResponse: AlbumInfoResponse) {
        self.init()

        self.albumId = albumInfoResponse.album.mbid
        self.name = albumInfoResponse.album.name
        self.artist = albumInfoResponse.album.artist
        self.mediumImageUrl = albumInfoResponse.album.image.first { $0.size == "medium" }?.url

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd MM yyyy, HH:mm"
//        self.releaseDate = dateFormatter.date(from: albumInfoResponse.album.releaseDate)

        let trackObjects = albumInfoResponse.album.tracks.track.map(TrackDatabaseObject.init)
        self.tracks = List<TrackDatabaseObject>()
        self.tracks.append(objectsIn: trackObjects)
    }
}

extension TrackDatabaseObject {
    convenience init(from track: AlbumInfoResponse.Track) {
        self.init()

        self.rank = track.attr.rank
        self.name = track.name
        self.artist = track.artist.name
        self.duration = Int(track.duration) ?? 0
    }
}
