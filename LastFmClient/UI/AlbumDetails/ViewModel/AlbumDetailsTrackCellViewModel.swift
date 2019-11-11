import Foundation

struct AlbumDetailsTrackCellViewModel {
    var track: String
    var trackLength: TimeInterval

    init (from trackData: TrackModel) {
        let artist = trackData.artist.count > 0 ? "\(trackData.artist) - " : ""
        self.track = artist + trackData.name
        self.trackLength = TimeInterval(trackData.duration)
    }
}
