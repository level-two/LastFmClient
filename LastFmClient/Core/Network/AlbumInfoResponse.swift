import Foundation

struct AlbumInfoResponse: Decodable {
    let album: AlbumInfo

    struct AlbumInfo: Decodable {
        let mbid: String
        let name: String
        let artist: String
        let tracks: Tracks
        let image: [Image]
    }

    struct Image: Decodable {
        let url: String
        let size: String

        enum CodingKeys: String, CodingKey {
            case url = "#text"
            case size
        }
    }

    struct Tracks: Decodable {
        let track: [Track]
    }

    struct Track: Decodable {
        let name: String
        let url: String
        let duration: String
        let attr: Attr
        let streamable: Streamable
        let artist: Artist

        enum CodingKeys: String, CodingKey {
            case name, url, duration
            case attr = "@attr"
            case streamable, artist
        }
    }

    struct Artist: Decodable {
        let name, mbid: String
        let url: String
    }

    struct Attr: Decodable {
        let rank: String
    }

    struct Streamable: Decodable {
        let text, fulltrack: String

        enum CodingKeys: String, CodingKey {
            case text = "#text"
            case fulltrack
        }
    }
}
