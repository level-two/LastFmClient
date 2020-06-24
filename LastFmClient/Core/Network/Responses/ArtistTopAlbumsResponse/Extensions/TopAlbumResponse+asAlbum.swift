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

extension TopAlbumResponse {

    var asAlbum: Album? {
        struct AlbumImp: Album {
            let mbid: String
            let title: String
            let artist: String
            let imageUrl: [ImageSize: String]
            let tracks: [Track]
        }

        guard let mbid = mbid else { return nil }

        let imageUrl = Dictionary(image.compactMap { $0.asImageUrl }, uniquingKeysWith: { _, new in new })

        let album = AlbumImp(mbid: mbid,
                             title: title,
                             artist: artistInfo.name,
                             imageUrl: imageUrl,
                             tracks: [])
        return album
    }

}
