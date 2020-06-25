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

final class DefaultFontSet: FontSet {
    var regular: UIFont { .systemFont(ofSize: 15.0) }
    var bold: UIFont { UIFont.systemFont(ofSize: 15.0, weight: .bold) }
    var light: UIFont { UIFont.systemFont(ofSize: 15.0, weight: .light) }
    var heading: UIFont { UIFont.systemFont(ofSize: 17.0) }
    var small: UIFont { .systemFont(ofSize: 12.0) }
}
