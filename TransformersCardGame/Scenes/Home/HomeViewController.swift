import UIKit
import Moya

class HomeViewController: UIViewController {

    var contentView: HomeView
    let viewModel = HomeViewModel()

    init() {
        contentView = HomeView()
        viewModel.viewDelegate = contentView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Transformers Card Game"
        view.addSubview(contentView)
        contentView.bindFrameToSuperviewBounds()
        addActions()
    }

    private func addActions() {
        contentView.didTapCreateTransformer = { [weak self] in
            guard let strongSelf = self else { return }

            strongSelf.viewModel.getTransformersList()
        }
    }
}
