import UIKit

class HomeView: UIView {

    private let JWTLabel: UILabel = {
        let label = UILabel()
        label.text = "JWT: "
        label.textColor = .black
        return label
    }()

    let JWTValueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        backgroundColor = .white
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        buildViewHierarchy()
        addConstraints()
    }

    private func buildViewHierarchy() {
        addSubview(JWTLabel)
        addSubview(JWTValueLabel)
    }

    private func addConstraints() {
        JWTLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(40)
        }

        JWTValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(JWTLabel.snp.centerY)
            make.left.equalTo(JWTLabel.snp.right).offset(40)
            make.right.equalToSuperview().inset(40)
        }
    }
}


