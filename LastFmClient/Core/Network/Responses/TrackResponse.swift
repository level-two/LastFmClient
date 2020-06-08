import Foundation

struct TrackResponse: Decodable {
    let name: String
    let duration: Int
    let trackRank: TrackRankResponse
    let trackArtist: TrackArtistResponse

    enum CodingKeys: String, CodingKey {
        case name
        case duration
        case trackRank = "@attr"
        case trackArtist = "artist"
    }
}
