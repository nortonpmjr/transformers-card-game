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
                    self.createTransformer()
                }
                catch let error {
                    debugPrint(error)
                }
            case let .failure(error):
                debugPrint(error)
            }
        }
    }

    func createTransformer() {
        let transformer: TransformerModel = TransformerModel(name: "Megatron", strength: 10, intelligence: 10, speed: 4, endurance: 8, rank: 10, courage: 9, firepower: 10, skill: 9, team: TransformerTeam.Decepticon)
        provider.request(.createTransformer(transformer: transformer)) { result in
            switch result {
            case let .success(response):
                do {
                    let t = try response.mapString()
                    debugPrint(t)
                }
                catch let error {
                    debugPrint(error)
                }
            case let .failure(failure):
                debugPrint(failure)
            }

        }
    }
}
