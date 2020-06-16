import Foundation

struct TopAlbumResponse: Decodable {
    let title: String
    let mbid: String?
    let artistInfo: TopAlbumArtistResponse
    let image: [ImageResponse]

    private enum CodingKeys: String, CodingKey {
        case title = "name"
        case mbid
        case artistInfo = "artist"
        case image
    }
}
