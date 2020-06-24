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

protocol ColorPalette {
    var base: UIColor { get }
    var light1: UIColor { get }
    var light2: UIColor { get }
    var dark1: UIColor { get }
    var dark2: UIColor { get }
    var primary1: UIColor { get }
    var primary2: UIColor { get }
    var primary3: UIColor { get }
    var primary4: UIColor { get }
    var primary5: UIColor { get }
}
