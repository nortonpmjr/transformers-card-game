import UIKit
import SnapKit

class TCGInputField: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let inputField: UIInputView = {
        let inputField = UIInputView()
        return inputField
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }

        inputField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
        }
    }
}
