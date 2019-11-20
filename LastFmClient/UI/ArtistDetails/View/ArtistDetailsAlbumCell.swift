import UIKit

class ArtistDetailsAlbumCell: UICollectionViewCell, NibLoadable {
    @IBOutlet weak var coverImage: UIImageView?
    @IBOutlet weak var tracksNumber: UILabel?
    @IBOutlet weak var albumTitle: UILabel?
    @IBOutlet weak var addButton: UIButton?
    @IBOutlet weak var removeButton: UIButton?

    var onAdd: (() -> Void)?
    var onRemove: (() -> Void)?

    fileprivate enum ButtonState {
        case add
        case remove
        case none
    }

    override public func awakeFromNib() {
        setupCell()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setupCell()
        onAdd = nil
        onRemove = nil
    }

    func configure(with viewModel: ArtistDetailsAlbumViewModel) {
        coverImage?.image = viewModel.cover
        tracksNumber?.text = "\(viewModel.tracksNumber)"
        albumTitle?.text = viewModel.title

        setButtonState(viewModel.isAlbumInCollection ? .remove : .add)
    }

    func style(with theme: Theme) {
        theme.apply(style: .normal, to: tracksNumber)
        theme.apply(style: .normal, to: albumTitle)
        theme.apply(style: .darkBackground, to: self.contentView)
        theme.apply(style: .subtleShadow, to: self.layer)
    }

    @IBAction func onAddButton(_ sender: UIButton) {
        self.onAdd?()
    }

    @IBAction func onRemoveButton(_ sender: UIButton) {
        self.onRemove?()
    }
}

extension ArtistDetailsAlbumCell {
    fileprivate func setupCell() {
        setButtonState(.none)

        self.layer.cornerRadius = 8
    }

    fileprivate func setButtonState(_ state: ButtonState) {
        addButton?.isHidden = !(state == .add)
        removeButton?.isHidden = !(state == .remove)
    }
}
