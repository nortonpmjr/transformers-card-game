import Foundation

enum TransformerTeam: String, Codable {
    case Decepticon = "D"
    case Autobot = "A"
}

struct TransformerModel: Codable {
    var name: String
    var strength: Int
    var intelligence: Int
    var speed: Int
    var endurance: Int
    var rank: Int
    var courage: Int
    var firepower: Int
    var skill: Int
    var team: TransformerTeam
    var id: String
    var teamIcon: String
}

extension TransformerModel {
    public var dictionary: [String: Any] {
        return ["name": name,
                "strength": strength,
                "intelligence": intelligence,
                "speed": speed,
                "endurance": endurance,
                "rank": rank,
                "courage": courage,
                "firepower": firepower,
                "skill": skill,
                "team": team.rawValue]
    }
}
