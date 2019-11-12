import Foundation
import UIKit

// FIXME: STUB!!
class NetworkService {
    func getImage(_ urlString: String, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.main.async {
            completion(UIImage(named: "Golova"))
        }
    }
}
