import UIKit

class AlbumCardCell: UICollectionViewCell {
    @IBOutlet weak var coverImage: UIImageView?
    @IBOutlet weak var tracksNumber: UILabel?
    @IBOutlet weak var tracksIcon: UIImageView?
    @IBOutlet weak var albumTitle: UILabel?
    @IBOutlet weak var artistName: UILabel?

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func awakeFromNib() {
        setupCell()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setupCell()
    }
}

extension AlbumCardCell {
    func setupCell() {
        tracksNumber?.text = "1"
    }
}
