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
    var id: String?
    var teamIcon: String?
}
