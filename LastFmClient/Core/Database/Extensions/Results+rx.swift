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
