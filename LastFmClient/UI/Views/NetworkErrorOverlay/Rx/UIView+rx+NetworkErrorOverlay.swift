import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {

    /// Showing Hud on secified view
    var showNetworkErrorOverlay: Binder<NetworkErrorOverlayInteractor?> {
        return Binder(self.base) { view, interactor in
            if let interactor = interactor {
                let overlay = NetworkErrorOverlayView(frame: view.bounds)
                overlay.setupInteractions(interactor)
                view.addSubview(overlay)
                overlay.translatesAutoresizingMaskIntoConstraints = false
                overlay.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                overlay.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                overlay.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                overlay.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            } else {
                view.subviews
                    .filter { $0 is NetworkErrorOverlayView }
                    .forEach { $0.removeFromSuperview() }
            }
        }
    }

}
