import Foundation
import Moya

class TransformerRepository {
    static var shared = TransformerRepository()
    let provider: MoyaProvider<NetworkService>
    var getTransformersCallback: ((_ transformers: [TransformerModel]) -> Void)?

    init() {
        provider = MoyaProvider<NetworkService>()
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

    func createTransformer(transformer: TransformerModel, completion: @escaping () -> Void) {
        provider.request(.createTransformer(transformer: transformer)) { result in
            switch result {
            case let .success(response):
                do {
                    let encoder = JSONDecoder()
                    let t = try encoder.decode(TransformerModel.self, from: response.data)
                    completion()
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

    func editTransformer(_ transformer: TransformerModel, completion: @escaping () -> Void) {
        provider.request(.updateTransformer(transformer: transformer)) { result in
            switch result {
            case let .success(response):
                debugPrint(response)
                completion()
            case let .failure(error):
                debugPrint(error)
            }
        }
    }

    func deleteTransformer(_ transformer: TransformerModel, completion: @escaping () -> Void) {
        provider.request(.deleteTransformer(transformer: transformer)) { result in
            switch result {
            case let .success(response):
                completion()
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
}
