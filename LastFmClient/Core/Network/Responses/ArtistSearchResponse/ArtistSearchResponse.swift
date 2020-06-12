import Foundation

struct ArtistSearchResponse {
    let matches: [ArtistSearchMatchResponse]
}

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
        matches = try artistsContainer.decode([ArtistSearchMatchResponse].self, forKey: .artists)
    }
}
