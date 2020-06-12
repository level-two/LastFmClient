import Alamofire

enum ArtistRequest {
    case search(artist: String)
}

extension ArtistRequest: LastFmEndpoint {
    var method: String {
        switch self {
        case .search: return "artist.search"
        }
    }

    var queryParameters: Parameters {
        switch self {
        case .search(let artist): return ["artist": artist]
        }
    }
}
