// -----------------------------------------------------------------------------
//    Copyright (C) 2020 Yauheni Lychkouski.
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
// -----------------------------------------------------------------------------

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
