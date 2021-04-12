import Foundation
import UIKit

final class AppCoordinator {
    weak var window: UIWindow?
    var navigationController: UINavigationController = UINavigationController()
    private var currentViewController: UIViewController?

    init(window: UIWindow) {
        self.window = window
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func start() {
        let vc = HomeViewController()
        currentViewController = vc
        navigationController.pushViewController(vc, animated: false)
    }

    func wantsToCreateHomeViewController() {

    }
}
