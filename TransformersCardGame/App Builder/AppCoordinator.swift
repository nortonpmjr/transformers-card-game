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
        createHomeViewController()
        navigationController.pushViewController(currentViewController!, animated: false)
    }

    func createHomeViewController() {
        let vc = HomeViewController()
        vc.wantsToShowCreationView = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.wantsToShowCreationView()
        }
        currentViewController = vc
    }

    func wantsToShowCreationView() {
        let vc = TransformerCreationViewController()
        currentViewController = vc
        vc.wantsToShowHome = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.wantsToShowHome()
        }

        navigationController.pushViewController(vc, animated: true)
    }

    func wantsToShowHome() {
        navigationController.popViewController(animated: true)
    }
}
