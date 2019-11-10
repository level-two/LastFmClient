import UIKit

class AlbumDetailsHeaderView: UITableViewHeaderFooterView, NibLoadable {
    @IBOutlet weak var cover: UIImageView?
    @IBOutlet weak var title: UILabel?
    @IBOutlet weak var artist: UILabel?
    @IBOutlet weak var year: UILabel?
    @IBOutlet weak var albumDescription: UILabel?

    func configure(with viewModel: AlbumDetailsHeaderViewModel) {
        self.cover?.image = viewModel.cover
        self.title?.text = viewModel.title
        self.artist?.text = viewModel.artist
        self.year?.text = viewModel.year
        self.albumDescription?.text = viewModel.albumDescription
    }

    func style(with theme: Theme) {
        theme.apply(style: .normal, to: title)
        theme.apply(style: .normal, to: artist)
        theme.apply(style: .dark, to: year)
        theme.apply(style: .description, to: albumDescription)
        theme.apply(style: .tableHeaderBackground, to: self.contentView)
    }
}
