import UIKit
import RxSwift
import RxCocoa

final class AlbumCardViewCell: UICollectionViewCell, NibLoadable {
    func set(viewModel: AlbumCardViewModel) {
        albumView?.set(viewModel: viewModel.albumViewModel)
        self.storeViewModel = viewModel.storeViewModel
        setupStoreAlbumInteractions()
    }

    func style(with theme: Theme?) {
        albumView?.style(with: theme)
        theme?.apply(style: .darkBackground, to: self.contentView)
        theme?.apply(style: .subtleShadow, cornerRadius: 8, to: contentView.layer)
    }

    @IBOutlet private weak var albumView: AlbumView?
    @IBOutlet private weak var storeButton: UIButton?

    private var storeViewModel: AlbumStoreViewModel?
    private var disposeBag = DisposeBag()
}

private extension AlbumCardViewCell {

    func setupStoreAlbumInteractions() {
        cleanPreviousBindings()

        guard let storeViewModel = storeViewModel else { return }

        storeButton?.rx.tap
            .bind(to: storeViewModel.store)
            .disposed(by: disposeBag)

        storeViewModel.stored.bind { [weak self] isStored in
            let image = UIImage(named: isStored ? "remove" : "add")
            self?.storeButton?.setImage(image, for: .normal)
        }.disposed(by: disposeBag)
    }

    func cleanPreviousBindings() {
        disposeBag = DisposeBag()
    }
}
