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

import RxSwift

protocol HomeScreenViewModel {
    var onStoredAlbums: Observable<[AlbumCardViewModel]> { get }
    var doSelectCard: AnyObserver<AlbumCardViewModel> { get }

    var onShowAlbumDetails: Observable<String> { get }

    var doArtistSearch: AnyObserver<String> { get }

    var onSearchResults: Observable<[ArtistSearchItem]> { get }
    var doSelectSearchItem: AnyObserver<ArtistSearchItem> { get }

    var onShowArtistDetails: Observable<String> { get }
}
