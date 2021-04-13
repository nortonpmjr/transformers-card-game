import UIKit
import Moya

class HomeViewController: UIViewController {

    var contentView: HomeView
    let provider = MoyaProvider<NetworkService>(plugins: [NetworkLoggerPlugin(verbose: true)])

    init() {
        contentView = HomeView()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = .red

        view.addSubview(contentView)
        contentView.bindFrameToSuperviewBounds()
        getToken()
    }

    func getToken() {
        provider.request(.getToken) { result in
            switch result {
            case let .success(response):
                do {
                    let token = try response.mapString()
                    self.contentView.JWTValueLabel.text = token
                    UserPreferences.addKey(token: token)
                }
                catch let error {
                    debugPrint(error)
                }
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
}
