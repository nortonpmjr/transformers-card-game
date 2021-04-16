import UIKit

enum ViewType {
    case create
    case edit
}

class TransformerCreationViewController: UIViewController {

    var contentView = TransformerCreationView()
    let viewModel = TransformerCreationViewModel()
    var viewType: ViewType = .create

    var wantsToShowHome: (() -> Void)?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentView)
        contentView.maxWidth = Int((view.bounds.size.width - 48) / 3)
        contentView.bindFrameToSuperviewBounds()
        contentView.setup()
        contentView.layoutIfNeeded()
        viewModel.delegate = contentView
        addActions()
        setup()
    }

    func setup() {

        switch viewType {
        case .create:
            navigationItem.title = "Transformer Creation"
        case .edit:
//            navigationItem.title = viewModel.transformer.name
            viewModel.wantsToEdit()
        }
    }

    func addActions() {
        contentView.wantsToCreateTransformer = { [weak self] transformer in
            guard let strongSelf = self else { return }
            strongSelf.viewType == .create ? strongSelf.viewModel.createTransformers(transformer) : strongSelf.viewModel.editTransformers(transformer)
        }

        contentView.wantsToShowHome = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.wantsToShowHome?()
        }

        initHideKeyboard()
    }

    func initHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
