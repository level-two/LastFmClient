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

struct DefaultAlbumCardViewModel: AlbumCardViewModel {
    let album: Album
    let albumViewModel: AlbumViewModel
    let storeViewModel: AlbumStoreViewModel

    init(album: Album, imageDownloadService: ImageDownloadService, albumStoreService: AlbumStoreService) {
        self.album = album
        albumViewModel = DefaultAlbumViewModel(album: album, imageDownloadService: imageDownloadService)
        storeViewModel = DefaultAlbumStoreViewModel(album: album, albumStoreService: albumStoreService)
    }
}
