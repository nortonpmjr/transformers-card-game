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
    private let teamInput = TCGInputField()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildViewHierarchy() {
        addSubview(nameInput)
        addSubview(strengthInput)
        addSubview(intelligenceInput)
        addSubview(speedInput)
        addSubview(enduranceInput)
        addSubview(rankInput)
        addSubview(courageInput)
        addSubview(firepowerInput)
        addSubview(skillInput)
        addSubview(teamInput)
    }

    private func addConstraints() {
        nameInput.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(24)
            make.height.equalTo(40)
        }

        strengthInput.snp.makeConstraints { make in
            make.leading.equalTo(nameInput.snp.leading)
            make.top.equalTo(nameInput.snp.bottom).offset(8)
            make.width.equalTo(32)
        }

        intelligenceInput.snp.makeConstraints { make in
            make.leading.equalTo(strengthInput.snp.trailing).offset(8)
            make.top.equalTo(strengthInput.snp.top)
            make.width.equalTo(32)
        }

        speedInput.snp.makeConstraints { make in
            make.leading.equalTo(intelligenceInput.snp.trailing).offset(8)
            make.top.equalTo(intelligenceInput.snp.top)
            make.width.equalTo(32)
        }

        enduranceInput.snp.makeConstraints { make in
            make.leading.equalTo(strengthInput.snp.leading)
            make.top.equalTo(strengthInput.snp.bottom).offset(8)
            make.width.equalTo(32)
        }

        rankInput.snp.makeConstraints { make in
            make.leading.equalTo(enduranceInput.snp.trailing).offset(8)
            make.top.equalTo(enduranceInput.snp.top)
            make.width.equalTo(32)
        }

    }
}

//
//addSubview(enduranceInput)
//addSubview(rankInput)
//addSubview(courageInput)
//addSubview(firepowerInput)
//addSubview(skillInput)
//addSubview(teamInput)
