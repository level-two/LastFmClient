import Foundation

struct ArtistSearchItemResponse: Decodable {
    let artist: String
    let mbid: String

    private enum CodingKeys: String, CodingKey {
        case artist = "name"
        case mbid
    }
}
