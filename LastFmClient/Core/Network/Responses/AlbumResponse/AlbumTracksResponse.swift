import Foundation

struct AlbumTracksResponse: Decodable {
    let tracks: [TrackResponse]

    private enum CodingKeys: String, CodingKey {
        case tracks = "track"
    }
}
