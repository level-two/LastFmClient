import UIKit

class AlbumDetailsAlbumCellView: UICollectionViewCell, NibLoadable, TypeIdentifiable {
    @IBOutlet private weak var albumView: AlbumView?

    func configure(with viewModel: AlbumViewModel) {
        albumView?.set(viewModel: viewModel)
    }

    func style(with theme: Theme?) {
        albumView?.style(with: theme)
        theme?.apply(style: .lightDarkBackground, to: self.contentView)
    }
}
