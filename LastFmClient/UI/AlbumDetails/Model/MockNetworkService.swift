import Foundation
import UIKit // FIXME: ????

// FIXME: STUB!!
class NetworkService {
    class Album {
        struct TrackInfo: Codable {
            var rank: Int
            var name: String
            var artist: String
            var duration: Int
        }

        struct AlbumInfo: Codable {
            var name: String
            var artist: String
            var releasedate: String
            var tracks: [TrackInfo]
            var mediumImageUrl: String
        }

        func getInfo(albumId: String, completion: @escaping (AlbumInfo) -> Void) {
            DispatchQueue.main.async {
                let tracks = [
                    TrackInfo(rank: 1, name: "Disintegrant", artist: "Golova!", duration: 701),
                    TrackInfo(rank: 2, name: "Stella Speculum", artist: "Golova!", duration: 508),
                    TrackInfo(rank: 3, name: "Phobic Correlation", artist: "Golova!", duration: 755),
                    TrackInfo(rank: 4, name: "Spectres", artist: "Golova!", duration: 304),
                    TrackInfo(rank: 5, name: "Radiant Aura", artist: "Golova!", duration: 337),
                    TrackInfo(rank: 6, name: "Immersion In Matter", artist: "Golova!", duration: 1910)
                ]
                let mockAlbumInfo = AlbumInfo(name: "Golova! (Self Titled)", artist: "Golova!",
                                              releasedate: "2012", tracks: tracks, mediumImageUrl: "")

                completion(mockAlbumInfo)
            }
        }
    }

    let album = Album()

    func getImage(_ urlString: String, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.main.async {
            completion(nil)
        }
    }
}
