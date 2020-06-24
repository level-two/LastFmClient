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

import RealmSwift

class AlbumObject: Object {
    @objc dynamic var mbid: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var artist: String = ""
    var albumTracks = List<TrackObject>()
    var albumImageUrl = List<ImageUrlObject>()

    required init() {
        super.init()
    }

    init(from album: Album) {
        super.init()
        self.mbid = album.mbid
        self.title = album.title
        self.artist = album.artist
        self.albumImageUrl.append(objectsIn: album.imageUrl.map(ImageUrlObject.init))
        self.albumTracks.append(objectsIn: album.tracks.map(TrackObject.init))
    }

    var toAlbum: Album {
        struct AlbumImp: Album {
            let mbid: String
            let title: String
            let artist: String
            let imageUrl: [ImageSize: String]
            let tracks: [Track]
        }

        let tracks = Array(albumTracks.map { $0.toTrack })
        let imageUrl = Dictionary(albumImageUrl.map { $0.toImageUrl }, uniquingKeysWith: { _, new in new })

        return AlbumImp(mbid: mbid, title: title, artist: artist, imageUrl: imageUrl, tracks: tracks)
    }
}
