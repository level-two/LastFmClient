import Foundation

extension TrackResponse: Track {
    var rank: Int {
        return trackRank.rank
    }

    var artist: String {
        return trackArtist.name
    }
}
