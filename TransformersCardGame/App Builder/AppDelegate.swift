import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var rootCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow()
        self.window = window

        let rootCoordinator = AppCoordinator(window: window)
        self.rootCoordinator = rootCoordinator

        rootCoordinator.start()

        // Override point for customization after application launch.
        return true
    }
}

