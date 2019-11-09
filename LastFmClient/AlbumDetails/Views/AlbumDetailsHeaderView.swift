import UIKit

class AlbumDetailsHeaderView: UITableViewHeaderFooterView, NibLoadable {
    @IBOutlet weak var cover: UIImageView?
    @IBOutlet weak var title: UILabel?
    @IBOutlet weak var artist: UILabel?
    @IBOutlet weak var year: UILabel?
    @IBOutlet weak var albumDescription: UILabel?
}
