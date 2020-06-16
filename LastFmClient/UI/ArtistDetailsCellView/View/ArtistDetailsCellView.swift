import UIKit
import RxSwift
import RxCocoa

final class ArtistDetailsCellView: UICollectionViewCell, NibLoadable {
    @IBOutlet private var artistPhoto: UIImageView?
    @IBOutlet private var name: UILabel?
    @IBOutlet private var shortDescription: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        clearBindings()
    }

    func configure(with viewModel: ArtistDetailsCellViewModel) {
        artistPhoto?.image = viewModel.photo
        name?.text = viewModel.name
        shortDescription?.text = viewModel.shortDescription
    }

    func style(with theme: Theme) {
        theme.apply(style: .normal, to: name)
        theme.apply(style: .normal, to: shortDescription)
        theme.apply(style: .lightDarkBackground, to: self)
    }

    private var disposeBag = DisposeBag()
}

extension ArtistDetailsCellView {
    fileprivate func setupView() {

    }

    func clearBindings() {
        disposeBag = DisposeBag()
    }
}
