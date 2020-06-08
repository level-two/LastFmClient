import Foundation

extension URL {
    func replacingLastPathComponent(_ pathComponent: String) -> URL {
        return deletingLastPathComponent().appendingPathComponent(pathComponent)
    }
}
