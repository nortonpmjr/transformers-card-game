import UIKit
import SnapKit

class TransformerCreationView: UIView {

// MARK: - View Elements
    private let nameInput = TCGInputField()
    private let strengthInput = TCGInputField()
    private let intelligenceInput = TCGInputField()
    private let speedInput = TCGInputField()
    private let enduranceInput = TCGInputField()
    private let rankInput = TCGInputField()
    private let courageInput = TCGInputField()
    private let firepowerInput = TCGInputField()
    private let skillInput = TCGInputField()

    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()

    private let firstRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()

    private let secondRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()

    private let thirdRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    }()

    private let teamStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    // Team Selection

    private let teamLabel: UILabel = {
        let label = UILabel()
        label.text = "Select your team"
        return label
    }()

    private let autobotButton: UIButton = {
        let button = UIButton()
        button.setTitle("Autobot", for: .normal)
        button.backgroundColor = .autobotRed
        button.layer.cornerRadius = 4
        return button
    }()

    private let deceptionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Decepticon", for: .normal)
        button.backgroundColor = .disabledGrey
        button.layer.cornerRadius = 4
        return button
    }()

    private var selectedTeam: TransformerTeam = .Autobot

    // Confirmation
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Transformer", for: .normal)
        button.backgroundColor = .successGreen
        button.layer.cornerRadius = 4
        return button
    }()

    // Actions
    public var wantsToCreateTransformer: ((_ transformer: TransformerModel) -> Void)?
    public var wantsToShowHome: (() -> Void)?
    public var wantsToShowAlert: ((_ message: String) -> Void)?

    private let inputFieldHeight = 72
    public var maxWidth: Int = 0

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setup() {
        buildViewHierarchy()
        addConstraints()
        setupInputs()
        autobotButton.addTarget(self, action: #selector(didTapAutobotButton), for: .touchUpInside)
        deceptionButton.addTarget(self, action: #selector(didTapDecepticonButton), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
    }

    private func setupInputs() {
        nameInput.titleLabel.text = "Name"
        nameInput.inputType = .text
        nameInput.delegate = self

        strengthInput.titleLabel.text = "Strenght"
        strengthInput.inputField.keyboardType = .numberPad
        strengthInput.delegate = self

        intelligenceInput.titleLabel.text = "Intelligence"
        intelligenceInput.inputField.keyboardType = .numberPad
        intelligenceInput.delegate = self

        speedInput.titleLabel.text = "Speed"
        speedInput.inputField.keyboardType = .numberPad
        speedInput.delegate = self

        enduranceInput.titleLabel.text = "Endurance"
        enduranceInput.inputField.keyboardType = .numberPad
        enduranceInput.delegate = self

        rankInput.titleLabel.text = "Rank"
        rankInput.inputField.keyboardType = .numberPad
        rankInput.delegate = self

        courageInput.titleLabel.text = "Courage"
        courageInput.inputField.keyboardType = .numberPad
        courageInput.delegate = self

        firepowerInput.titleLabel.text = "Firepower"
        firepowerInput.inputField.keyboardType = .numberPad
        firepowerInput.delegate = self

        skillInput.titleLabel.text = "Skill"
        skillInput.inputField.keyboardType = .numberPad
        skillInput.delegate = self
    }

    private func buildViewHierarchy() {
        addSubview(verticalStackView)
        addSubview(nameInput)
        verticalStackView.addArrangedSubview(firstRowStackView)
        verticalStackView.addArrangedSubview(secondRowStackView)
        verticalStackView.addArrangedSubview(thirdRowStackView)

        firstRowStackView.addArrangedSubview(strengthInput)
        firstRowStackView.addArrangedSubview(intelligenceInput)
        firstRowStackView.addArrangedSubview(speedInput)

        secondRowStackView.addArrangedSubview(enduranceInput)
        secondRowStackView.addArrangedSubview(rankInput)
        secondRowStackView.addArrangedSubview(courageInput)

        thirdRowStackView.addArrangedSubview(firepowerInput)
        thirdRowStackView.addArrangedSubview(skillInput)

        addSubview(teamLabel)
        addSubview(teamStackView)
        teamStackView.addArrangedSubview(autobotButton)
        teamStackView.addArrangedSubview(deceptionButton)
        addSubview(confirmButton)
    }
}

extension TransformerCreationView {
    private func addConstraints() {
        // Row 1
        nameInput.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(8)
            make.height.equalTo(inputFieldHeight)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(nameInput.snp.bottom).offset(16)
            make.leading.equalTo(nameInput.snp.leading)
            make.trailing.equalTo(nameInput.snp.trailing)
        }

        teamLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameInput.snp.leading)
            make.top.equalTo(verticalStackView.snp.bottom).offset(8)
            make.height.equalTo(32)
        }

        teamStackView.snp.makeConstraints { make in
            make.top.equalTo(teamLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameInput.snp.leading)
            make.trailing.equalTo(nameInput.snp.trailing)
            make.height.equalTo(40)
        }

        confirmButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(40)
        }
    }
}

extension TransformerCreationView {
    @objc private func didTapAutobotButton() {
        autobotButton.backgroundColor = .autobotRed
        deceptionButton.backgroundColor = .disabledGrey
        selectedTeam = .Autobot
    }

    @objc private func didTapDecepticonButton() {
        autobotButton.backgroundColor = .disabledGrey
        deceptionButton.backgroundColor = .decepticonPurple
        selectedTeam = .Decepticon
    }

    @objc private func didTapCreateButton() {
        let transformer = TransformerModel(name: nameInput.textInput(), strength: strengthInput.intInput(), intelligence: intelligenceInput.intInput(), speed: speedInput.intInput(), endurance: enduranceInput.intInput(), rank: rankInput.intInput(), courage: courageInput.intInput(), firepower: firepowerInput.intInput(), skill: skillInput.intInput(), team: selectedTeam)

        wantsToCreateTransformer?(transformer)
    }
}

extension TransformerCreationView: TransformerCreationViewModelDelegateType {
    func transformerCreated() {
        wantsToShowHome?()
    }

    func trasnformerToEdit(_ transformer: TransformerModel) {
        nameInput.inputField.text = transformer.name
        strengthInput.inputField.text = transformer.strength.description
        intelligenceInput.inputField.text = transformer.intelligence.description
        speedInput.inputField.text = transformer.speed.description
        enduranceInput.inputField.text = transformer.endurance.description
        rankInput.inputField.text = transformer.rank.description
        courageInput.inputField.text = transformer.courage.description
        firepowerInput.inputField.text = transformer.firepower.description
        skillInput.inputField.text = transformer.skill.description

        selectedTeam = transformer.team

        if selectedTeam == .Autobot {
            autobotButton.backgroundColor = .autobotRed
            deceptionButton.backgroundColor = .disabledGrey
        } else {
            autobotButton.backgroundColor = .disabledGrey
            deceptionButton.backgroundColor = .decepticonPurple
        }
    }
}

extension TransformerCreationView: TCGInputFieldDelegate {
    func showAlert(_ message: String) {
        wantsToShowAlert?(message)
    }
}
