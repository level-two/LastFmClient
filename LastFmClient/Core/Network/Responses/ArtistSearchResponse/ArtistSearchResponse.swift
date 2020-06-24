import Foundation

struct ArtistSearchResponse {
    let matches: [ArtistSearchItemResponse]
}

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

extension ArtistSearchResponse: Decodable {
    private enum RootKey: String, CodingKey {
        case results
    }

    private enum MatchesKey: String, CodingKey {
        case matches = "artistmatches"
    }

    private enum ArtistsKey: String, CodingKey {
        case artists = "artist"
    }

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootKey.self)
        let matchesContainer = try rootContainer.nestedContainer(keyedBy: MatchesKey.self, forKey: .results)
        let artistsContainer = try matchesContainer.nestedContainer(keyedBy: ArtistsKey.self, forKey: .matches)
        matches = try artistsContainer.decode([ArtistSearchItemResponse].self, forKey: .artists)
    }
}
