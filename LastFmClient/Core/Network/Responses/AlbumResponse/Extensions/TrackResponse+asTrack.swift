extension TrackResponse {

    var asTrack: Track {
        struct TrackImp: Track {
            let rank: Int
            let name: String
            let artist: String
            let duration: Int
        }

        return TrackImp(rank: rank.rank,
                        name: name,
                        artist: artist.name,
                        duration: duration)
    }

}
