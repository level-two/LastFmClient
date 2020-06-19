import UIKit
import RxSwift
import RxCocoa

final class ArtistDetailsCellView: UICollectionViewCell, NibLoadable {
    @IBOutlet private var artistPhoto: UIImageView?
    @IBOutlet private var name: UILabel?
    @IBOutlet private var shortDescription: UILabel?
    @IBOutlet private var hudView: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cleanBindings()
    }

    func configure(with viewModel: ArtistDetailsCellViewModel) {
        self.viewModel = viewModel
        setupView()
    }

    func style(with theme: Theme) {
        theme.apply(style: .normal, to: name)
        theme.apply(style: .normal, to: shortDescription)
        theme.apply(style: .lightDarkBackground, to: self)
    }

    private var viewModel: ArtistDetailsCellViewModel?
    private var disposeBag = DisposeBag()
}

private extension ArtistDetailsCellView {
    func setupView() {
        cleanBindings()

        name?.text = viewModel?.name
        shortDescription?.text = viewModel?.shortDescription

        setupBindings()
    }

    func setupBindings() {
        guard let viewModel = viewModel,
            let hudView = hudView,
            let artistPhoto = artistPhoto
        else { return }

        viewModel.artistPhoto
            .bind(to: artistPhoto.rx.image)
            .disposed(by: disposeBag)

        viewModel.showLoadingHud
            .map { !$0 }
            .bind(to: hudView.rx.isHidden)
            .disposed(by: disposeBag)
    }

    func cleanBindings() {
        disposeBag = DisposeBag()
    }
}
