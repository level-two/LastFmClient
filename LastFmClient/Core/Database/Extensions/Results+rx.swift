import RealmSwift
import RxSwift

extension Results {
    var asObservable: Observable<Results> {
        return Observable.create { observer in
            let token = self.observe { change in
                switch change {
                case .initial(let results), .update(let results, _, _, _):
                    observer.onNext(results)
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
