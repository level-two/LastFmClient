import UIKit

@UIApplicationMain
class ApplicationMain: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var sceneNavigator: SceneNavigator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navigationController = UINavigationController()
        let sceneNavigator = SceneNavigator(navigationController: navigationController)
        window?.rootViewController = navigationController

        sceneNavigator.navigate(to: .homeScreen)

        return true
    }
}
