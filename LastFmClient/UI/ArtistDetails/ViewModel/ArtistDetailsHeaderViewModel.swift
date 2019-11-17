import UIKit

struct ArtistDetailsHeaderViewModel {
    let photo: UIImage?
    let name: String
    let shortDescription: String

    static var mock: ArtistDetailsHeaderViewModel {
        return .init(
            photo: UIImage(named: "Golova"),
            name: "Golova",
            shortDescription: """
                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
            """)
    }
}
