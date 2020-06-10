import UIKit
import RxSwift
import RxCocoa

final class AlbumCardViewCell: UICollectionViewCell, NibLoadable {
    func set(viewModel: AlbumCardViewModel) {
        self.viewModel = viewModel
        viewModel.downloadContent()
    }

    func style(with theme: Theme?) {
        theme?.apply(style: .normal, to: artist)
        theme?.apply(style: .normal, to: title)
        theme?.apply(style: .darkBackground, to: self.contentView)

        [contentView, cover, coverLoadingHud].compactMap { $0?.layer }.forEach {
            theme?.apply(style: .subtleShadow, cornerRadius: 8, to: $0)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cleanBindings()
        self.viewModel = nil
    }

    private var viewModel: AlbumCardViewModel? { didSet { setupView() } }
    private var disposeBag = DisposeBag()

    @IBOutlet private weak var artist: UILabel?
    @IBOutlet private weak var title: UILabel?
    @IBOutlet private weak var cover: UIImageView?
    @IBOutlet private weak var coverLoadingHud: UIView?
    @IBOutlet private weak var storeButton: UIButton?
}

private extension AlbumCardViewCell {
    func setupView() {
        cleanBindings()

        guard let viewModel = viewModel else { return }

        artist?.text = viewModel.artist
        title?.text = viewModel.title
        setupBindings()
    }

    func setupBindings() {
        guard let viewModel = viewModel,
            let loadingHud = coverLoadingHud,
            let cover = cover
        else { return }

        viewModel.onCover
            .bind(to: cover.rx.image)
            .disposed(by: disposeBag)

        viewModel.onShowLoadingHud
            .map { !$0 }
            .bind(to: loadingHud.rx.isHidden)
            .disposed(by: disposeBag)

        storeButton?.rx.tap
            .bind(to: viewModel.onStoreButton)
            .disposed(by: disposeBag)
    }

    func cleanBindings() {
        disposeBag = DisposeBag()
    }
}
