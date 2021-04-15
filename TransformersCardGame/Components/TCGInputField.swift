import UIKit
import SnapKit

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

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(inputField)
        addConstraints()
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
