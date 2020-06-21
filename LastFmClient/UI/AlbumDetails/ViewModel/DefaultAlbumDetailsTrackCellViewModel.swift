import Foundation

class DefaultAlbumDetailsTrackCellViewModel: AlbumDetailsTrackCellViewModel {
    let title: String

    var duration: String {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        if trackDuration >= 3600 { formatter.allowedUnits.insert(.hour) }
        return formatter.string(from: Double(trackDuration)) ?? ""
    }

    private let trackDuration: Int

    init(from track: Track) {
        self.title = track.name
        self.trackDuration = track.duration
    }
}
