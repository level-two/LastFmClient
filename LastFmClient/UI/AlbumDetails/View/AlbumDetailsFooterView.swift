import UIKit

class AlbumDetailsFooterView: UITableViewHeaderFooterView, NibLoadable {
    @IBOutlet weak var addButton: UIButton?
    @IBOutlet weak var removeButton: UIButton?

//    func configure(with viewModel: AlbumDetailsFooterModel) {
//        setState(viewModel.isAlbumInCollection)
//    }

    func configure() {
        setState(true)
    }

    func setState(_ isAlbumInCollection: Bool) {
        addButton?.isHidden = isAlbumInCollection
        removeButton?.isHidden = !isAlbumInCollection
    }

    func style(with theme: Theme) {
        theme.apply(style: .addButton, to: addButton)
        theme.apply(style: .removeButton, to: removeButton)
        theme.apply(style: .tableFooterBackground, to: self.contentView)
    }
}
