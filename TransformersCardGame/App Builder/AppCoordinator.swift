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

        vc.wantsToShowEditViewFor = { [weak self] transformer in
            guard let strongSelf = self else { return }
            strongSelf.wantsToShowEditViewFor(transformer)
        }

        currentViewController = vc
    }

    func wantsToShowCreationView() {
        createTransformerCreationViewController()
        navigationController.pushViewController(currentViewController!, animated: true)
    }

    func createTransformerCreationViewController() {
        let vc = TransformerCreationViewController()
        currentViewController = vc
        vc.wantsToShowHome = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.wantsToShowHome()
        }
        currentViewController = vc
    }

    func wantsToShowEditViewFor(_ transformer: TransformerModel) {
        createTransformerCreationViewController()
        guard let vc = currentViewController as? TransformerCreationViewController else { return }
        vc.viewModel.transformer = transformer
        vc.viewType = .edit
        vc.setup()
        navigationController.pushViewController(vc, animated: true)
    }

    func wantsToShowHome() {
        navigationController.popViewController(animated: true)
    }
}
