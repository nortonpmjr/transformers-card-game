import UIKit

class TransformerCreationViewController: UIViewController {

    var contentView = TransformerCreationView()
    let viewModel = TransformerCreationViewModel()

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
        contentView.bindFrameToSuperviewBounds()
        contentView.maxWidth = Int((view.bounds.size.width - 48) / 3)
        contentView.setup()
        contentView.layoutIfNeeded()
        viewModel.delegate = contentView
        navigationItem.title = "Transformer Creation"

        addActions()
    }

    func addActions() {
        contentView.wantsToCreateTransformer = { [weak self] transformer in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.createTransformers(transformer)
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
