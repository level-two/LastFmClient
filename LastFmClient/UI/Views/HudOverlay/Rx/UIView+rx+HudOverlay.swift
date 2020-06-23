import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {

    /// Showing Hud on secified view
    var showHud: Binder<Bool> {
        return Binder(self.base) { view, show in
            if show {
                let overlay = HudOverlayView(frame: view.bounds)
                view.addSubview(overlay)
                overlay.translatesAutoresizingMaskIntoConstraints = false
                overlay.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                overlay.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                overlay.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                overlay.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            } else {
                view.subviews
                    .filter { $0 is HudOverlayView }
                    .forEach { $0.removeFromSuperview() }
            }
        }
    }

}
