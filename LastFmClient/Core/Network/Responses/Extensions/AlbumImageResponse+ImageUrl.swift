//
//  AlbumImageResponse+ImageSize.swift
//  LastFmClient
//
//  Created by Yauheni Lychkouski on 6/9/20.
//  Copyright © 2020 Yauheni Lychkouski. All rights reserved.
//

import Foundation

extension AlbumImageResponse {
    var imageUrl: (size: ImageSize, url: String)? {
        switch size {
        case "small":
            return (.small, url)
        case "medium":
            return (.medium, url)
        case "large":
            return (.large, url)
        default:
            return nil
        }
    }
}
