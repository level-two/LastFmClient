//
//  DefaultArtistDescriptionViewModel.swift
//  LastFmClient
//
//  Created by Yauheni Lychkouski on 6/16/20.
//  Copyright © 2020 Yauheni Lychkouski. All rights reserved.
//

import Foundation

final class DefaultArtistDescriptionViewModel: ArtistDescriptionViewModel {
    let attributedDescription: NSAttributedString

    init?(with html: String) {
        guard let data = html.data(using: .utf8) else { return nil }

        let attributedText = try? NSAttributedString(data: data,
                                  options: [.documentType: NSAttributedString.DocumentType.html,
                                            .characterEncoding: String.Encoding.utf8.rawValue],
                                  documentAttributes: nil)

        guard let text = attributedText else { return nil }

        attributedDescription = text
    }
}
