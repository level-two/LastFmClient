// -----------------------------------------------------------------------------
//    Copyright (C) 2020 Yauheni Lychkouski.
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
// -----------------------------------------------------------------------------

import UIKit

class AlbumDetailsTrackCellView: UICollectionViewCell, NibLoadable, TypeIdentifiable {
    @IBOutlet weak var track: UILabel?
    @IBOutlet weak var duration: UILabel?
    @IBOutlet weak var image: UIImageView?

    func configure(with viewModel: AlbumDetailsTrackCellViewModel) {
        self.track?.text = viewModel.title
        self.duration?.text = viewModel.duration
    }

    func style(with theme: Theme?) {
        theme?.apply(style: .text, to: track)
        theme?.apply(style: .light, to: duration)
        theme?.apply(style: .tint, to: image)
        theme?.apply(style: .background, to: self.contentView)
    }
}
