import RealmSwift

extension Realm {
    static var `default`: Realm {
        do {
            return try Realm(configuration: .default())
        } catch {
            fatalError("Failed instantiate Realm: \(error)")
        }
    }
}
