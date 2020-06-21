import PromiseKit

private enum PromiseError: Error {
    case failed
}

extension Promise {
    static var failed: Promise<T> {
        return Promise(error: PromiseError.failed)
    }
}
