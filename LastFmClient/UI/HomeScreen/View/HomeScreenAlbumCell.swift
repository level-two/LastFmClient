import UIKit

class HomeScreenAlbumCell: UICollectionViewCell, NibLoadable {
    @IBOutlet weak var coverImage: UIImageView?
    @IBOutlet weak var tracksNumber: UILabel?
    @IBOutlet weak var albumTitle: UILabel?
    @IBOutlet weak var removeButton: UIButton?

    var onRemove: (() -> Void)?

    override public func awakeFromNib() {
        setupCell()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setupCell()
        onRemove = nil
    }

    func configure(with viewModel: HomeScreenAlbumViewModel) {
        coverImage?.image = viewModel.cover
        tracksNumber?.text = "\(viewModel.tracksNumber)"
        albumTitle?.text = viewModel.title
    }

    func style(with theme: Theme) {
        theme.apply(style: .normal, to: tracksNumber)
        theme.apply(style: .normal, to: albumTitle)
        theme.apply(style: .darkBackground, to: self)
        theme.apply(style: .subtleShadow, to: self.layer)
    }

    @IBAction func onRemoveButton(_ sender: UIButton) {
        self.onRemove?()
    }
}

extension HomeScreenAlbumCell {
    fileprivate func setupCell() {
        self.layer.cornerRadius = 8
    }
}
