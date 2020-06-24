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

final class DefaultArtistDescriptionViewModel: ArtistDescriptionViewModel {
    let attributedDescription: NSAttributedString

    init(with html: String) {
        let modifiedFontSize = """
            <span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(UIFont.labelFontSize)\">
                \(html)
            </span>
        """

        let data = modifiedFontSize.data(using: .utf8) ?? Data()
        let attributedString =
            try? NSAttributedString(data: data,
                                    options: [.documentType: NSAttributedString.DocumentType.html,
                                              .characterEncoding: String.Encoding.utf8.rawValue],
                                    documentAttributes: nil)
        attributedDescription = attributedString ?? NSAttributedString()
    }
}
