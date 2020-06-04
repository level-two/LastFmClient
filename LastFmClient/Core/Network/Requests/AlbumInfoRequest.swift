import Foundation

enum AlbumInfoRequest {
    case info(albumId: String)
}

extension AlbumInfoRequest: LastFmEndpoint {
    var method: String {
        switch self {
        case .info: return "album.getinfo"
        }
    }

    var parameters: [String: String] {
        switch self {
        case .info(let albumId): return ["mbid": albumId]
        }
    }
}
