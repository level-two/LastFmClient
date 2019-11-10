import UIKit

class AlbumDetailsTrackCell: UITableViewCell, NibLoadable {
    @IBOutlet weak var track: UILabel?
    @IBOutlet weak var trackLength: UILabel?

    func configure(with viewModel: AlbumDetailsTrackCellViewModel) {
        self.track?.text = viewModel.track
        self.trackLength?.text = viewModel.trackLength.formatted
    }

    func style(with theme: Theme) {
        theme.apply(style: .normal, to: track)
        theme.apply(style: .normal, to: trackLength)
        theme.apply(style: .tableCellBackground, to: self.contentView)
    }
}

extension TimeInterval {
    var formatted: String? {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]

        if self >= 3600 {
            formatter.allowedUnits.insert(.hour)
        }

        return formatter.string(from: self)
    }
}
