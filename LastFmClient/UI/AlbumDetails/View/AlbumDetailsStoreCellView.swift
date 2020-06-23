import UIKit
import RxSwift
import RxCocoa

class AlbumDetailsStoreCellView: UICollectionViewCell, NibLoadable, TypeIdentifiable {
    @IBOutlet private weak var button: UIButton?

    override func prepareForReuse() {
        super.prepareForReuse()
        clearBindings()
    }

    func configure(with viewModel: AlbumStoreViewModel) {
        self.viewModel = viewModel
        setupBindings()
    }

    func style(with theme: Theme) {
        self.theme = theme
        theme.apply(style: .lightDarkBackground, to: self.contentView)
    }

    private var viewModel: AlbumStoreViewModel?
    private var theme: Theme?
    private var disposeBag = DisposeBag()
}

private extension AlbumDetailsStoreCellView {
    func setupBindings() {
        clearBindings()

        guard let viewModel = viewModel else { return }

        viewModel.stored.bind { [weak self] isStored in
            self?.theme?.apply(style: isStored ? .removeButton : .addButton, to: self?.button)
            self?.button?.setTitle(isStored ? "remove" : "add", for: .normal)
            self?.button?.setImage(UIImage(named: isStored ? "remove" : "add"), for: .normal)
        }.disposed(by: disposeBag)

        button?.rx.tap
            .bind(to: viewModel.store)
            .disposed(by: disposeBag)
    }

    func clearBindings() {
        disposeBag = DisposeBag()
    }
}
