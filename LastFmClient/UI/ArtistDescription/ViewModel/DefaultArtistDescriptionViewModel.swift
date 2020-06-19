import Foundation

final class DefaultArtistDescriptionViewModel: ArtistDescriptionViewModel {
    let attributedDescription: NSAttributedString

    init(with html: String) {
        let data = html.data(using: .utf8) ?? Data()
        let attributedString =
            try? NSAttributedString(data: data,
                                    options: [.documentType: NSAttributedString.DocumentType.html,
                                              .characterEncoding: String.Encoding.utf8.rawValue],
                                    documentAttributes: nil)
        attributedDescription = attributedString ?? NSAttributedString()
    }
}
