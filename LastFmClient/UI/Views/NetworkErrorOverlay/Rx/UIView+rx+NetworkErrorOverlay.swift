import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {

    /// Showing Hud on secified view
    var showNetworkErrorOverlay: Binder<NetworkErrorOverlayInteractor?> {
        var overlayInstance: NetworkErrorOverlayView?

        return Binder(self.base) { view, interactor in
            overlayInstance?.removeFromSuperview()
            overlayInstance = nil

            if let interactor = interactor {
                let overlay = NetworkErrorOverlayView(frame: view.bounds)
                overlay.setupInteractions(interactor)
                view.addSubview(overlay)
                overlay.translatesAutoresizingMaskIntoConstraints = false
                overlay.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                overlay.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                overlay.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                overlay.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
                overlayInstance = overlay
            }
        }
    }

}
