import Alamofire

enum ArtistRequest {
    case search(artist: String)
    case getInfo(mbid: String)
    case getTopAlbums(mbid: String)
}

extension ArtistRequest: LastFmEndpoint {
    var method: String {
        switch self {
        case .search: return "artist.search"
        case .getInfo: return "artist.getInfo"
        case .getTopAlbums: return "artist.getTopAlbums"
        }
    }

    var queryParameters: Parameters {
        switch self {
        case .search(let artist): return ["artist": artist]
        case .getInfo(let mbid): return ["mbid": mbid]
        case .getTopAlbums(let mbid): return ["mbid": mbid]
        }
    }
}
