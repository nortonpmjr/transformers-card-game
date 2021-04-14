import UIKit

class HomeView: UIView {


// MARK: - View Elements
    private let emptyListView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 4
        return view
    }()

    private let emptyListText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = "You don't have any Transformer. \n Click here to create one."
        label.textColor = .black
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()

// MARK: - Variables
    private var tapGestureRecognizer: UITapGestureRecognizer?
    var didTapCreateTransformer: (() -> Void)?

// MARK: - Lifecycle
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        addActions()
        backgroundColor = .white
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        buildViewHierarchy()
        addConstraints()
        addActions()
    }

    private func buildViewHierarchy() {
        addSubview(emptyListView)
        emptyListView.addSubview(emptyListText)
    }

    private func addConstraints() {
        emptyListView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.greaterThanOrEqualTo(80)
            make.height.equalTo(200)
        }

        emptyListText.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.lessThanOrEqualToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }
    }

    private func addActions() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(wantsToCreateTransformer))

        emptyListView.isUserInteractionEnabled = true
        emptyListView.addGestureRecognizer(tapGestureRecognizer!)
    }

    @objc private func wantsToCreateTransformer() {
        didTapCreateTransformer?()
    }
}

// MARK: - View Model Bindings

extension HomeView: HomeViewModelDelegateType {
    func transformersUpdated(_ transformers: [TransformerModel]) {
        if transformers.count > 0 {
            emptyListView.isHidden = true
        } else {
            emptyListView.isHidden = false
        }

        emptyListView.layoutIfNeeded()
    }
}


