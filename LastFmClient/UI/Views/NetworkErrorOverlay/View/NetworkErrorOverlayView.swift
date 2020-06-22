import UIKit
import RxSwift
import RxCocoa

final class NetworkErrorOverlayView: UIView, NibLoadable {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }

    func setupInteractions(_ interactor: NetworkErrorOverlayInteractor) {
        button?.rx.tap
            .bind { interactor.retry.onNext(()) }
            .disposed(by: disposeBag)
    }

    private var disposeBag = DisposeBag()

    @IBOutlet private weak var button: UIButton?
}
