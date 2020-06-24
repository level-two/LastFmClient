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

import RealmSwift

class ImageUrlObject: Object {
    @objc dynamic var size: ImageSizeObject = .small
    @objc dynamic var url: String = ""

    required init() {
        super.init()
    }

    init(size: ImageSize, url: String) {
        super.init()
        self.size = ImageSizeObject(from: size)
        self.url = url
    }

    var toImageUrl: (ImageSize, String) {
        return (size.toImageSize, url)
    }
}
