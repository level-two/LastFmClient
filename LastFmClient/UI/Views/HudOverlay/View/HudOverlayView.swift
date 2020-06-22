import UIKit

final class HudOverlayView: UIView, NibLoadable {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?
}
