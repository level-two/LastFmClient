import Alamofire

enum AlbumRequest {
    case info(mbid: String)
}

extension AlbumRequest: LastFmEndpoint {
    var method: String {
        switch self {
        case .info: return "album.getinfo"
        }
    }

    var queryParameters: Parameters {
        switch self {
        case .info(let mbid): return ["mbid": mbid]
        }
    }
}
