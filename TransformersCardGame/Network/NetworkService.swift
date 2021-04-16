import Moya

enum NetworkService {
    case getToken
    case createTransformer(transformer: TransformerModel)
    case getTransformer
    case updateTransformer(transformer: TransformerModel)
    case deleteTransformer(transformer: TransformerModel)
}

extension NetworkService: TargetType {

    var baseURL: URL { return URL(string: "https://transformers-api.firebaseapp.com")! }

    var path: String {
        switch self {
        case .getToken:
            return "/allspark"
        case let .deleteTransformer(transformer):
            return "/transformers/\(transformer.id)"
        default:
            return "/transformers"
        }
    }

    var method: Method {
        switch self {
        case .getToken, .getTransformer:
            return .get
        case .createTransformer:
            return .post
        case .updateTransformer:
             return .put
        case .deleteTransformer:
            return .delete
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getToken:
            return .requestPlain
        case let .createTransformer(transformer):
            return .requestParameters(parameters: transformer.dictionary, encoding: JSONEncoding.default)
        case let .updateTransformer(transformer):
            return .requestParameters(parameters: transformer.dictionary, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    var headers: [String : String]? {

        switch self {
        case .getToken:
            return ["Content-Type": "application/json"]
        default:
            let token = UserPreferences.getKey() ?? ""
            return ["Authorization": "Bearer \(token)",
                    "Content-Type": "application/json"]
        }
    }
}
