protocol TypeIdentifiable {
    static var defaultIdentifier: String { get }
}

extension TypeIdentifiable {
    static var defaultIdentifier: String {
        return String(describing: Self.self)
    }
}
