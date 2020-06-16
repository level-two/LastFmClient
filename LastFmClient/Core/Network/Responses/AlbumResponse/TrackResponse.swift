import Foundation

struct TrackResponse: Decodable {
    let name: String
    let duration: Int
    let rank: TrackRankResponse
    let artist: TrackArtistResponse

    private enum CodingKeys: String, CodingKey {
        case name
        case duration
        case rank = "@attr"
        case artist
    }
}
