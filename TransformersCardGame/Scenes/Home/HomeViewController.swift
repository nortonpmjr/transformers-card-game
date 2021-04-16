import UIKit
import SnapKit
import Lottie

class HomeViewController: UIViewController {

// MARK: - View Elements
    private let emptyListView: UIView = {
        let view = UIView()
        view.backgroundColor = .disabledGrey
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 4
        view.isHidden = true
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
        tableView.separatorStyle = .none
        return tableView
    }()

    private let lottieView: AnimationView = {
        let animation = AnimationView()
        animation.contentMode = .scaleAspectFit
        let startAnimation = Animation.named("robot")
        animation.animation = startAnimation
        return animation
    }()

    private let battleAnimation: AnimationView = {
        let view = AnimationView()
        view.contentMode = .scaleAspectFit
        let animation = Animation.named("chatbot")
        view.animation = animation
        view.isHidden = true
        return view
    }()

    private let battleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Battle", for: .normal)
        button.backgroundColor = .successGreen
        button.setTitleColor(.white, for: .normal)
        button.isHidden = true
        button.layer.cornerRadius = 4
        return button
    }()

// MARK: - Variables
    private var tapGestureRecognizer: UITapGestureRecognizer?
    var didTapCreateTransformer: (() -> Void)?
    var didTapBattle: (() -> Void)?
    private var transformCardIdentifier: String = "transformerCard"
    private var autobotsDataSource: [TransformerModel] = []
    private var decepticonsDataSource: [TransformerModel] = []

    typealias ActionCallback = (_ transformer: TransformerModel) -> Void

    var wantsToEditCallback: ActionCallback?
    var wantsToDeleteCallback: ActionCallback?

    let viewModel = HomeViewModel()

    var wantsToShowCreationView: (() -> Void)?
    var wantsToShowEditViewFor: ((_ transformer: TransformerModel) -> Void)?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDelegate = self
        navigationItem.title = "Transformers Card Game"
        view.backgroundColor = .white
        setup()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTransformer))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.getTransformersList()
        lottieView.loopMode = .loop
        lottieView.play()
    }

    private func addActions() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addTransformer))

        emptyListView.isUserInteractionEnabled = true
        emptyListView.addGestureRecognizer(tapGestureRecognizer!)

        battleButton.addTarget(self, action: #selector(wantsToBattle), for: .touchUpInside)
    }

    @objc func addTransformer() {
        wantsToShowCreationView?()
    }

    func setup() {
        addActions()
        buildViewHierarchy()
        addConstraints()
        setupTableView()
    }

    private func buildViewHierarchy() {
        view.addSubview(emptyListView)
        emptyListView.addSubview(emptyListText)
        view.addSubview(tableView)
        view.addSubview(battleButton)
        view.addSubview(lottieView)
        view.addSubview(battleAnimation)
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
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }

        lottieView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(120)
        }

        battleButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(40)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }

        battleAnimation.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(120)
        }
    }

    private func setupTableView() {
        tableView.register(TransformerCardCell.self, forCellReuseIdentifier: transformCardIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
    }

    @objc private func wantsToBattle() {
        viewModel.calculateBattle()
    }
}

extension HomeViewController: HomeViewModelDelegateType {
    func transformersUpdated(_ transformers: [TransformerModel]) {

        UIView.animate(withDuration: TimeInterval(5)) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.emptyListView.isHidden = transformers.count > 0
            strongSelf.tableView.isHidden = transformers.count <= 0
            strongSelf.battleButton.isHidden = transformers.count <= 0
            strongSelf.lottieView.isHidden = true
            strongSelf.lottieView.stop()
        }
        emptyListView.layoutIfNeeded()
        lottieView.layoutIfNeeded()
        tableView.layoutIfNeeded()
        autobotsDataSource = transformers.filter { $0.team == TransformerTeam.Autobot }
        decepticonsDataSource = transformers.filter { $0.team == TransformerTeam.Decepticon }

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func finishedBattle(result: BattleResult) {
        battleAnimation.isHidden = false
        battleAnimation.play { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.showResultAlert(result)
        }

    }

    private func showResultAlert(_ result: BattleResult) {
        battleAnimation.isHidden = true
        let winninegTeam = result.winningTeam == TransformerTeam.Autobot ? result.autobotSurvivors : result.decepticonSurvivors
        let winninegTeamString = winninegTeam.map { $0.name }.joined(separator: ",")

        let loserTeam = result.winningTeam == TransformerTeam.Autobot ? result.decepticonSurvivors : result.autobotSurvivors
        let loserTeamString = loserTeam.map { $0.name }.joined(separator: ",")

        let losingTeam = result.winningTeam == TransformerTeam.Autobot ? "Decepticon" : "Autobot"

        let message = "\(result.battleCount) battles \n Winnineg team(\(String(describing: result.winningTeam!))): \(winninegTeamString) \n Survivors from losing team (\(losingTeam)): \(loserTeamString)"
        let alertView = UIAlertController(title: "Battle Result", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return autobotsDataSource.count
        case 1:
            return decepticonsDataSource.count
        default:
            return 0
        }
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: transformCardIdentifier, for: indexPath) as? TransformerCardCell else { return UITableViewCell() }

        switch indexPath.section {
        case 0:
            cell.transformer = autobotsDataSource[indexPath.row]
        case 1:
            cell.transformer = decepticonsDataSource[indexPath.row]
        default:
            return cell
        }
        
        cell.setupCell()
        cell.contentView.isUserInteractionEnabled = false

        cell.wantsToDeleteCallback = { [weak self] transformer in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.deleteTransformer(transformer)
        }

        cell.wantsToEditCallback = { [weak self] transformer in
            guard let strongSelf = self else { return }
            strongSelf.wantsToShowEditViewFor?(transformer)
        }

        return cell
    }
}
