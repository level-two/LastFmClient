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
