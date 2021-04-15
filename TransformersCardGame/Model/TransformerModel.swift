import Foundation

enum TransformerTeam: String, Codable {
    case Decepticon = "D"
    case Autobot = "A"
}

struct TransformerModel: Codable {
    var name: String = ""
    var strength: Int = 0
    var intelligence: Int = 0
    var speed: Int = 0
    var endurance: Int = 0
    var rank: Int = 0
    var courage: Int = 0
    var firepower: Int = 0
    var skill: Int = 0
    var team: TransformerTeam = .Autobot
    var id: String = ""
    var teamIcon: String = ""

    enum CodingKeys: String, CodingKey {
        case teamIcon = "team_icon"
        case name
        case strength
        case intelligence
        case speed
        case endurance
        case rank
        case courage
        case firepower
        case skill
        case team
        case id
    }
}
