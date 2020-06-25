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

extension UIView {

    /// Showing Hud on secified view
    func showHud(_ show: Bool, theme: Theme?) {
        if show {
            let overlay = HudOverlayView(frame: self.bounds)
            self.addSubview(overlay)
            overlay.translatesAutoresizingMaskIntoConstraints = false
            overlay.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            overlay.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            overlay.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            overlay.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        } else {
            self.subviews
                .filter { $0 is HudOverlayView }
                .forEach { $0.removeFromSuperview() }
        }
    }

}
