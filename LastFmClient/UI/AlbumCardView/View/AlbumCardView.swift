import UIKit

class AlbumCardView: UIView, NibLoadable {
    @IBOutlet weak var coverImage: UIImageView?
    @IBOutlet weak var tracksNumber: UILabel?
    @IBOutlet weak var albumTitle: UILabel?
    @IBOutlet weak var removeButton: UIButton?

    private var viewModel: AlbumCardViewModel?

    func configure(with viewModel: AlbumCardViewModel) {
        self.viewModel = viewModel
        
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
        viewModel?.onRemove()
    }
}
