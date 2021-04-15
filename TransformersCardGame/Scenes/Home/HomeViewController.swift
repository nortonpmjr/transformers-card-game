import UIKit

class HomeViewController: UIViewController {

    var contentView: HomeView
    let viewModel = HomeViewModel()

    var wantsToShowCreationView: (() -> Void)?

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

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTransformer))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.getTransformersList()
    }

    private func addActions() {
        contentView.didTapCreateTransformer = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.wantsToShowCreationView?()
        }

        contentView.wantsToEditCallback = { [weak self] transformer in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.editTransformer(transformer)
        }

        contentView.wantsToDeleteCallback = { [weak self] transformer in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.deleteTransformer(transformer)
        }
    }

    @objc func addTransformer() {
        wantsToShowCreationView?()
    }
}
