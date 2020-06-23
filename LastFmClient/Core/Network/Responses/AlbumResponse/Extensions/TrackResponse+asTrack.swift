extension TrackResponse {

    var asTrack: Track {
        struct TrackImp: Track {
            let rank: Int
            let name: String
            let artist: String
            let duration: Int
        }

        return TrackImp(rank: Int(rank.rank) ?? 0,
                        name: name,
                        artist: artist.name,
                        duration: Int(duration) ?? 0)
    }

}
