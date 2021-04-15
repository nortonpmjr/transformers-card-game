import UIKit

class HomeView: UIView {


// MARK: - View Elements
    private let emptyListView: UIView = {
        let view = UIView()
        view.backgroundColor = .disabledGrey
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

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.contentMode = .scaleAspectFit
        return tableView
    }()

// MARK: - Variables
    private var tapGestureRecognizer: UITapGestureRecognizer?
    var didTapCreateTransformer: (() -> Void)?
    private var transformCardIdentifier: String = "transformerCard"
    private var transformerDataSource: [TransformerModel] = []

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
        setupTableView()
    }

    private func buildViewHierarchy() {
        addSubview(emptyListView)
        emptyListView.addSubview(emptyListText)
        addSubview(tableView)
    }

    private func addConstraints() {
        emptyListView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(160)
        }

        emptyListText.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.lessThanOrEqualToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }

    private func setupTableView() {
        tableView.register(TransformerCardCell.self, forCellReuseIdentifier: transformCardIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
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
            tableView.isHidden = false
        } else {
            emptyListView.isHidden = false
            tableView.isHidden = true
        }

        emptyListView.layoutIfNeeded()
        transformerDataSource = transformers

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension HomeView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transformerDataSource.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Autobots"
        case 1:
            return "Decepticons"
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard transformerDataSource.count > 0, let cell = tableView.dequeueReusableCell(withIdentifier: transformCardIdentifier, for: indexPath) as? TransformerCardCell else { return UITableViewCell() }

        cell.transformer = transformerDataSource[indexPath.row]
        cell.setupCell()

        return cell
    }
}
