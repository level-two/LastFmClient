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
import RxSwift

extension Results {
    var asObservable: Observable<[Element]> {
        return Observable.create { observer in
            let token = self.observe { change in
                switch change {
                case .initial(let results), .update(let results, _, _, _):
                    observer.onNext(Array(results))
                case let .error(error):
                    observer.onError(error)
                    return
                }
            }

            return Disposables.create {
                token.invalidate()
            }
        }
    }
}
