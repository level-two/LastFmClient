import Foundation

struct AlbumImageResponse: Decodable {
    let url: String
    let size: String

    enum CodingKeys: String, CodingKey {
        case url = "#text"
        case size
    }
}
