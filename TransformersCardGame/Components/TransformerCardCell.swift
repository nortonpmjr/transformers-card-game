import UIKit
import SnapKit
import Kingfisher

class TransformerCardCell: UITableViewCell {

    private let nameLabel: UILabel = {
        return UILabel()
    }()

    private let strenghtLabel: UILabel = {
        let label = UILabel()
        label.text = "Strength"
        return label
    }()

    private let strenghtValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()

    private let intelligenceLabel: UILabel = {
        let label = UILabel()
        label.text = "Intelligence"
        return label
    }()

    private let intelligenceValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()

    private let speedLabel: UILabel = {
        let label = UILabel()
        label.text = "Speed"
        return label
    }()

    private let speedValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()

    private let enduranceLabel: UILabel = {
        let label = UILabel()
        label.text = "Endurance"
        return label
    }()

    private let enduranceValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()

    private let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "Rank"
        return label
    }()

    private let rankValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()

    private let courageLabel: UILabel = {
        let label = UILabel()
        label.text = "Courage"
        return label
    }()

    private let courageValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()

    private let firepowerLabel: UILabel = {
        let label = UILabel()
        label.text = "Firepower"
        return label
    }()

    private let firepowerValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()

    private let skilLabel: UILabel = {
        let label = UILabel()
        label.text = "Skill"
        return label
    }()

    private let skillValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()

    private let overallRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "Overall Rating"
        return label
    }()

    private let overallRatingValue: UILabel = {
        let label = UILabel()
        label.text = "0.0"
        return label
    }()

    private let iconImageView: UIImageView = {
        return UIImageView()
    }()

    private let skillsLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()

    private let skillsValueStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()

    private let deleteButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "deleteIcon")
        button.setImage(image, for: .normal)
        return button
    }()

    private let editButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "editIcon")
        button.setImage(image, for: .normal)
        return button
    }()

    private let parentView: UIView = {
        let view = UIView()
        return view
    }()

    var transformer: TransformerModel?

    typealias ActionCallback = (_ transformer: TransformerModel) -> Void

    var wantsToEditCallback: ActionCallback?
    var wantsToDeleteCallback: ActionCallback?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell() {
        guard let transformer = self.transformer else { return }

        isUserInteractionEnabled = true

        parentView.layer.cornerRadius = 8
        parentView.layer.borderWidth = 1
        parentView.layer.borderColor = UIColor.black.cgColor
        parentView.clipsToBounds = true


        nameLabel.text = transformer.name
        strenghtValue.text = transformer.strength.description
        intelligenceValue.text = transformer.intelligence.description
        speedValue.text = transformer.speed.description
        enduranceValue.text = transformer.endurance.description
        rankValue.text = transformer.rank.description
        courageValue.text = transformer.courage.description
        firepowerValue.text = transformer.firepower.description
        skillValue.text = transformer.skill.description
        overallRatingValue.text = transformer.overallRating.description

        buildViewHierarchy()
        addConstraints()
        addActions()

        editButton.isUserInteractionEnabled = true
        deleteButton.isUserInteractionEnabled = true
        editButton.contentMode = .scaleAspectFit
        deleteButton.contentMode = .scaleAspectFit

        let imageURL = transformer.teamIcon
        let url = URL(string: imageURL)
        iconImageView.kf.setImage(with: url)
    }

    func buildViewHierarchy() {
        addSubview(parentView)

        parentView.addSubview(nameLabel)
        parentView.addSubview(iconImageView)
        parentView.addSubview(skillsLabelStackView)
        parentView.addSubview(skillsValueStackView)
        parentView.addSubview(overallRatingLabel)
        parentView.addSubview(overallRatingValue)

        skillsLabelStackView.addArrangedSubview(strenghtLabel)
        skillsLabelStackView.addArrangedSubview(intelligenceLabel)
        skillsLabelStackView.addArrangedSubview(speedLabel)
        skillsLabelStackView.addArrangedSubview(enduranceLabel)
        skillsLabelStackView.addArrangedSubview(rankLabel)
        skillsLabelStackView.addArrangedSubview(courageLabel)
        skillsLabelStackView.addArrangedSubview(firepowerLabel)
        skillsLabelStackView.addArrangedSubview(skilLabel)
        skillsLabelStackView.addArrangedSubview(overallRatingLabel)

        skillsValueStackView.addArrangedSubview(strenghtValue)
        skillsValueStackView.addArrangedSubview(intelligenceValue)
        skillsValueStackView.addArrangedSubview(speedValue)
        skillsValueStackView.addArrangedSubview(enduranceValue)
        skillsValueStackView.addArrangedSubview(rankValue)
        skillsValueStackView.addArrangedSubview(courageValue)
        skillsValueStackView.addArrangedSubview(firepowerValue)
        skillsValueStackView.addArrangedSubview(skillValue)
        skillsValueStackView.addArrangedSubview(overallRatingValue)

        parentView.addSubview(deleteButton)
        parentView.addSubview(editButton)
    }

    func addConstraints() {

        parentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview()
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }

        skillsLabelStackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel.snp.leading)
            make.bottom.equalToSuperview().inset(16)
        }

        skillsValueStackView.snp.makeConstraints { make in
            make.top.equalTo(skillsLabelStackView.snp.top)
            make.bottom.equalTo(skillsLabelStackView.snp.bottom)
            make.leading.equalTo(skillsLabelStackView.snp.trailing).offset(8)
        }

        iconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(16)
            make.height.width.equalTo(80)
        }

        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(16)
            make.bottom.equalToSuperview().inset(40)
        }

        editButton.snp.makeConstraints { make in
            // delete buttont trailing + delete button size + offset
            make.trailing.equalToSuperview().inset(40)
            make.width.height.equalTo(16)
            make.centerY.equalTo(deleteButton.snp.centerY)
        }
    }

    func addActions() {
        editButton.addTarget(self, action: #selector(wantsToEdit), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(wantsToDelete), for: .touchUpInside)
    }

    @objc func wantsToEdit() {
        guard let transformer = transformer else { return }
        wantsToEditCallback?(transformer)
    }

    @objc func wantsToDelete() {
        guard let transformer = transformer else { return }
        wantsToDeleteCallback?(transformer)
    }
}
