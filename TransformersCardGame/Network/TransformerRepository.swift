import Foundation
import Moya

class TransformerRepository {
    let provider: MoyaProvider<NetworkService>

    var getTransformersCallback: ((_ transformers: [TransformerModel]) -> Void)?

    init() {
        provider = MoyaProvider<NetworkService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    }

    func getToken() {
        provider.request(.getToken) { result in
            switch result {
            case let .success(response):
                do {
                    let token = try response.mapString()
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

    func getTransformers() {
        provider.request(.getTransformer) { result in
            switch result {
            case let .success(response):
                do {
                    struct Transformers: Decodable {
                        let transformers: [TransformerModel]
                    }
                    let decoder = JSONDecoder()
                    let t = try decoder.decode(Transformers.self, from: response.data)
                    self.getTransformersCallback?(t.transformers)
                }
                catch let error {
                    debugPrint(error)
                }

            case let .failure(failure):
                    debugPrint(failure)
            }
        }
    }

    func createTransformer(transformer: TransformerModel) {
        provider.request(.createTransformer(transformer: transformer)) { result in
            switch result {
            case let .success(response):
                do {
                    let encoder = JSONDecoder()
                    let t = try encoder.decode(TransformerModel.self, from: response.data)
//                    self.transformer.id = t.id
//                    self.transformer.teamIcon = t.teamIcon
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
