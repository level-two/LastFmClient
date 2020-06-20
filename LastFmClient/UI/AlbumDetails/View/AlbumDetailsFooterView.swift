import UIKit
import RxSwift
import RxCocoa

class AlbumDetailsFooterView: UITableViewHeaderFooterView, NibLoadable {
    @IBOutlet private weak var button: UIButton?

    override func prepareForReuse() {
        super.prepareForReuse()
        clearBindings()
    }

    func configure(with viewModel: AlbumDetailsFooterViewModel, theme: Theme) {
        self.viewModel = viewModel
        self.theme = theme
        setupBindings()
    }

    func style(with theme: Theme) {
        theme.apply(style: .lightDarkBackground, to: self.contentView)
    }

    private var viewModel: AlbumDetailsFooterViewModel?
    private var theme: Theme?
    private var disposeBag = DisposeBag()
}

private extension AlbumDetailsFooterView {
    func setupBindings() {
        clearBindings()

        guard let viewModel = viewModel else { return }

        viewModel.stored.bind { [weak self] isStored in
            self?.theme?.apply(style: isStored ? .removeButton : .addButton, to: self?.button)
            self?.button?.setTitle(isStored ? "remove" : "add", for: .normal)
            self?.button?.setImage(UIImage(named: isStored ? "remove" : "add"), for: .normal)
        }.disposed(by: disposeBag)

        button?.rx.tap
            .bind(to: viewModel.storeAlbum)
            .disposed(by: disposeBag)
    }

    func clearBindings() {
        disposeBag = DisposeBag()
    }
}
