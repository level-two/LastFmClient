import Foundation

struct AlbumInfoResponse: Decodable {
    let mbid: String
    let name: String
    let artist: String
    let tracks: AlbumTracksResponse
    let image: [AlbumImageResponse]
}
