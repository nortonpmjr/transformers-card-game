import UIKit
import SnapKit

enum inputFieldType {
    case text
    case number
}

protocol TCGInputFieldDelegate {
    func showAlert(_ message: String)
}

class TCGInputField: UIView {

    public let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    public let inputField: UITextField = {
        let inputField = UITextField()
        inputField.layer.cornerRadius = 4
        inputField.layer.borderWidth = 1
        inputField.layer.borderColor = UIColor.gray.cgColor
        inputField.backgroundColor = .grey226
        return inputField
    }()

    var inputType: inputFieldType = .number
    var delegate: TCGInputFieldDelegate?

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(inputField)
        addConstraints()
        inputField.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(32)
        }

        inputField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(40) 
        }
    }

    func textInput() -> String {
        return inputField.text ?? ""
    }

    func intInput() -> Int {
        return Int(inputField.text ?? "") ?? 0
    }
}

extension TCGInputField: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard inputType == .number else { return true }
        let intText = Int(textField.text ?? "") ?? 0
        if intText <= 0 || intText > 10 {
            inputField.text = ""
            delegate?.showAlert("Attribute fields should be between 1 and 10")
            return false
        }

        return true
    }
}
