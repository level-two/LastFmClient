import Foundation
import UIKit

// FIXME: STUB!!
class NetworkService {
    class Album {
        struct TrackInfoResponse: Codable {
            let rank: Int
            let name: String
            let artist: String
            let duration: Int
        }

        struct AlbumInfoResponse: Codable {
            let albumId: String
            let name: String
            let artist: String
            let releaseDate: String
            let tracks: [TrackInfoResponse]
            let mediumImageUrl: String
        }

        func getInfo(albumId: String, completion: @escaping (AlbumInfoResponse) -> Void) {
            DispatchQueue.main.async {
                let tracks = [
                    TrackInfoResponse(rank: 1, name: "Disintegrant", artist: "Golova!", duration: 701),
                    TrackInfoResponse(rank: 2, name: "Stella Speculum", artist: "Golova!", duration: 508),
                    TrackInfoResponse(rank: 3, name: "Phobic Correlation", artist: "Golova!", duration: 755),
                    TrackInfoResponse(rank: 4, name: "Spectres", artist: "Golova!", duration: 304),
                    TrackInfoResponse(rank: 5, name: "Radiant Aura", artist: "Golova!", duration: 337),
                    TrackInfoResponse(rank: 6, name: "Immersion In Matter", artist: "Golova!", duration: 1910)
                ]
                let mockAlbumInfo = AlbumInfoResponse(albumId: "61bf0388-b8a9-48f4-81d1-7eb02706dfb0",
                                                      name: "Golova! (Self Titled)", artist: "Golova!",
                                                      releaseDate: "2012", tracks: tracks, mediumImageUrl: "")

                completion(mockAlbumInfo)
            }
        }
    }

    let album = Album()

    func getImage(_ urlString: String, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.main.async {
            completion(UIImage(named: "Golova"))
        }
    }
}
