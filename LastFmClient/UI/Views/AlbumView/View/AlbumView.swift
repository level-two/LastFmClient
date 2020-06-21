import UIKit
import RxSwift
import RxCocoa

final class AlbumView: UIView, NibLoadable {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        loadFromNib()
    }

    func set(viewModel: AlbumViewModel?) {
        self.viewModel = viewModel
        setupView()
    }

    func style(with theme: Theme?) {
        theme?.apply(style: .normal, to: artist)
        theme?.apply(style: .normal, to: title)
        theme?.apply(style: .darkBackground, to: self)
    }

    private var viewModel: AlbumViewModel?
    private var disposeBag = DisposeBag()

    @IBOutlet private weak var artist: UILabel?
    @IBOutlet private weak var title: UILabel?
    @IBOutlet private weak var cover: UIImageView?
    @IBOutlet private weak var coverLoadingHud: UIView?
}

private extension AlbumView {
    func setupView() {
        setupStaticData()
        bindDynamicData()
    }

    func setupStaticData() {
        artist?.text = viewModel?.artist
        title?.text = viewModel?.title
    }

    func bindDynamicData() {
        cleanPreviousBindings()

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
    }

    func cleanPreviousBindings() {
        disposeBag = DisposeBag()
    }
}
