import UIKit

private class HudOverlay: UIView {
    var blurEffectView: UIVisualEffectView?

    override init(frame: CGRect) {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView = blurEffectView
        super.init(frame: frame)
        addSubview(blurEffectView)
        addLoader()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addLoader() {
        guard let blurEffectView = blurEffectView else { return }
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        activityIndicator.startAnimating()
    }
}

extension UIView {
    func showHudOverlay() {
        let blurLoader = HudOverlay(frame: frame)
        self.addSubview(blurLoader)
    }

    func removeHudOverlay() {
        if let blurLoader = subviews.first(where: { $0 is HudOverlay }) {
            blurLoader.removeFromSuperview()
        }
    }
}

extension UIViewController {
    func showHudOverlay() {
        view.showHudOverlay()
    }

    func removeHudOverlay() {
        view.removeHudOverlay()
    }
}
