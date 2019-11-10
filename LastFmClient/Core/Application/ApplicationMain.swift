import UIKit

@UIApplicationMain
class ApplicationMain: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var sceneNavigator: SceneNavigator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navigationController = UINavigationController()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        let sceneNavigator = SceneNavigator(navigationController: navigationController)
        sceneNavigator.navigate(to: .homeScreen)

        return true
    }
}
