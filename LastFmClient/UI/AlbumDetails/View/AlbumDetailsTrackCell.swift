import UIKit

class AlbumDetailsTrackCell: UITableViewCell, NibLoadable {
    @IBOutlet weak var track: UILabel?
    @IBOutlet weak var trackLength: UILabel?

    func configure(with viewModel: AlbumDetailsTrackCellViewModel) {
        self.track?.text = viewModel.title
        self.trackLength?.text = viewModel.duration
    }

    func style(with theme: Theme) {
        theme.apply(style: .normal, to: track)
        theme.apply(style: .dark, to: trackLength)
        theme.apply(style: .lightDarkBackground, to: self.contentView)
    }
}
