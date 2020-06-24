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

final class DefaultColorPalette: ColorPalette {
    var base: UIColor { UIColor(hex: 0xC0C0C0) }
    var light1: UIColor { UIColor(hex: 0xFFFFFF) }
    var light2: UIColor { UIColor(hex: 0xECECEC) }
    var dark1: UIColor { UIColor(hex: 0x262626) }
    var dark2: UIColor { UIColor(hex: 0x353535) }
    var primary1: UIColor { UIColor(hex: 0xAD916B) }
    var primary2: UIColor { UIColor(hex: 0xFBEAD4) }
    var primary3: UIColor { UIColor(hex: 0xD0B898) }
    var primary4: UIColor { UIColor(hex: 0x8A6E4A) }
    var primary5: UIColor { UIColor(hex: 0x725329) }
}
