import UIKit

class ArtistDetailsHeaderView: UICollectionReusableView, NibLoadable {
    @IBOutlet weak var artistPhoto: UIImageView?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var shortDescription: UILabel?

    var onDescriptionTapped: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        onDescriptionTapped = nil
    }

    func configure(with viewModel: ArtistDetailsHeaderViewModel) {
        artistPhoto?.image = viewModel.photo
        name?.text = viewModel.name
        shortDescription?.text = viewModel.shortDescription
    }

    func style(with theme: Theme) {
        theme.apply(style: .normal, to: name)
        theme.apply(style: .normal, to: shortDescription)
        theme.apply(style: .lightDarkBackground, to: self)
    }
}

extension ArtistDetailsHeaderView {
    fileprivate func setupView() {

    }

    @IBAction func onDescriptionLabelTap(_ sender: Any) {
        onDescriptionTapped?()
    }
}
