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

class TrackObject: Object {
    @objc dynamic var rank: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var artist: String = ""
    @objc dynamic var duration: Int = 0

    required init() {
        super.init()
    }

    init(from track: Track) {
        super.init()
        self.rank = track.rank
        self.name = track.name
        self.artist = track.artist
        self.duration = track.duration
    }

    var toTrack: Track {
        struct TrackImp: Track {
            let rank: Int
            let name: String
            let artist: String
            let duration: Int
        }

        return TrackImp(rank: rank, name: name, artist: artist, duration: duration)
    }
}
