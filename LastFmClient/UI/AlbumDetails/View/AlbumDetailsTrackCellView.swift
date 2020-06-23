import UIKit

class AlbumDetailsTrackCellView: UICollectionViewCell, NibLoadable, TypeIdentifiable {
    @IBOutlet weak var track: UILabel?
    @IBOutlet weak var duration: UILabel?

    func configure(with viewModel: AlbumDetailsTrackCellViewModel) {
        self.track?.text = viewModel.title
        self.duration?.text = viewModel.duration
    }

    func style(with theme: Theme?) {
        theme?.apply(style: .normal, to: track)
        theme?.apply(style: .dark, to: duration)
        theme?.apply(style: .lightDarkBackground, to: self.contentView)
    }
}
