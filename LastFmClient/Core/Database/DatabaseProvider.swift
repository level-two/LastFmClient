import RealmSwift

protocol DatabaseProvider {
    var defaultRealm: Realm { get }
}
