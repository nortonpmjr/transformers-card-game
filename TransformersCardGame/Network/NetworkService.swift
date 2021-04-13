import Moya

enum NetworkService {
    case getToken
    case createTransformer
    case getTransformer
    case updateTransformer
    case deleteTransformer
}

extension NetworkService: TargetType {

    var baseURL: URL { return URL(string: "https://transformers-api.firebaseapp.com")! }

    var path: String {
        switch self {
        case .getToken:
            return "/allspark"
        default:
            return "transformers"
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
//        case .createTransformer:
        default:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return ["Authorization": "Bearer",
                "Content-type": "application/json"]
    }
}
