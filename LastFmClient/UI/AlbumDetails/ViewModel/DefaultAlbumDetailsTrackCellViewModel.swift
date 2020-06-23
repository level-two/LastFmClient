import Foundation

class DefaultAlbumDetailsTrackCellViewModel: AlbumDetailsTrackCellViewModel {
    let title: String
    let duration: String

    init(from track: Track) {
        self.title = track.name

        let trackDuration = track.duration
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        if trackDuration >= 3600 { formatter.allowedUnits.insert(.hour) }
        self.duration = formatter.string(from: Double(trackDuration)) ?? ""
    }
}
