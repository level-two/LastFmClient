import UIKit

class AlbumDetailsFooterView: UITableViewHeaderFooterView, NibLoadable {
    @IBOutlet weak var addButton: UIButton?
    @IBOutlet weak var removeButton: UIButton?

    var onAdd: (() -> Void)?
    var onRemove: (() -> Void)?

    fileprivate enum ButtonState {
        case add
        case remove
        case none
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setupView()
        onAdd = nil
        onRemove = nil
    }

    func configure(with viewModel: AlbumDetailsFooterViewModel) {
        setButtonState(viewModel.isAlbumInCollection ? .remove : .add)
    }

    func style(with theme: Theme) {
        theme.apply(style: .addButton, to: addButton)
        theme.apply(style: .removeButton, to: removeButton)
        theme.apply(style: .tableFooterBackground, to: self.contentView)
    }

    @IBAction func onAddButton(_ sender: UIButton) {
        self.onAdd?()
    }

    @IBAction func onRemoveButton(_ sender: UIButton) {
        self.onRemove?()
    }
}

extension AlbumDetailsFooterView {
    fileprivate func setupView() {
        setButtonState(.none)
    }

    fileprivate func setButtonState(_ state: ButtonState) {
        addButton?.isHidden = !(state == .add)
        removeButton?.isHidden = !(state == .remove)
    }
}
