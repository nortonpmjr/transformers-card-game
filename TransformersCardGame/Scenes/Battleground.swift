import Foundation

class Battleground {
    public static let shared: Battleground = Battleground()

    public func startBattle(_ transformers: [TransformerModel]) -> BattleResult {
        var battleResult = BattleResult()
        var autobots = transformers.filter { $0.team == .Autobot }
        var decepticons = transformers.filter { $0.team == .Decepticon }

        autobots.sort { (lhs, rhs) -> Bool in
            rhs.overallRating <= lhs.overallRating
        }

        decepticons.sort { (lhs, rhs) -> Bool in
            rhs.overallRating <= lhs.overallRating
        }

        battleResult.autobotSurvivors = autobots
        battleResult.decepticonSurvivors = decepticons

        let numberOfFights = autobots.count >= decepticons.count ? decepticons.count : autobots.count

        var autobotsWins = 0
        var decepticonWins = 0

        for fight in 0..<numberOfFights {
            battleResult.battleCount += 1
            let autoContender = autobots[fight]
            let deceContender = decepticons[fight]

            // Lack Courage and Strength
            let courageDiff = autoContender.courage - deceContender.courage;
            let strengthDiff = autoContender.strength - deceContender.strength;
            let PREDAKING = "Predaking"
            let OPTIMUS = "Optimus Prime"

            if (autoContender.name == OPTIMUS || autoContender.name == PREDAKING) && (deceContender.name == OPTIMUS || deceContender.name == PREDAKING) {
                battleResult.autobotSurvivors.removeAll()
                battleResult.decepticonSurvivors.removeAll()
                battleResult.winningTeam = nil
                break
            }

            if autoContender.name == OPTIMUS || autoContender.name == PREDAKING && (deceContender.name != OPTIMUS || deceContender.name != PREDAKING) {
                autobotsWins += 1
                battleResult.decepticonSurvivors.removeAll { $0 == deceContender }
                continue
            }
            else if (deceContender.name == OPTIMUS || deceContender.name == PREDAKING && (autoContender.name != OPTIMUS || autoContender.name != PREDAKING)) {
                decepticonWins += 1
                battleResult.autobotSurvivors.removeAll { $0 == autoContender }
                continue
            }

            if abs(courageDiff) >= 3 && abs(strengthDiff) >= 4 {
                if courageDiff > 0 && strengthDiff > 0 {
                    autobotsWins += 1
                    battleResult.decepticonSurvivors.removeAll { $0 == deceContender }
                    continue
                } else if courageDiff < 0 && strengthDiff < 0 {
                    decepticonWins += 1
                    battleResult.autobotSurvivors.removeAll { $0 == autoContender }
                    continue
                }
            }

            // Skill rule
            if autoContender.skill-3 > deceContender.skill {
                autobotsWins += 1
                battleResult.decepticonSurvivors.removeAll { $0 == deceContender }
                continue
            } else if deceContender.skill-3 > autoContender.skill {
                decepticonWins += 1
                battleResult.autobotSurvivors.removeAll { $0 == autoContender }
                continue
            }

            // base rule
            if autoContender.overallRating > deceContender.overallRating {
                autobotsWins += 1
                battleResult.decepticonSurvivors.removeAll { $0 == deceContender }
                continue
            } else if deceContender.overallRating > autoContender.overallRating {
                decepticonWins += 1
                battleResult.autobotSurvivors.removeAll { $0 == autoContender }
                continue
            }

            battleResult.decepticonSurvivors.removeAll { $0 == deceContender }
            battleResult.autobotSurvivors.removeAll { $0 == autoContender }
        }

        if (autobotsWins > 0 || decepticonWins > 0) {
            battleResult.winningTeam = decepticonWins > autobotsWins ? .Decepticon : .Autobot
        }

        return battleResult
    }
}

public struct BattleResult {
    var battleCount: Int = 0
    var winningTeam: TransformerTeam?
    var autobotSurvivors: [TransformerModel] = []
    var decepticonSurvivors: [TransformerModel] = []
}

//The basic rules of the battle are:
//● The teams should be sorted by rank and faced off one on one against each other in order to determine a victor, the loser is eliminated
//● A battle between opponents uses the following rules:
//○ If any fighter is down 4 or more points of courage and 3 or more points of strength
//compared to their opponent, the opponent automatically wins the face-off regardless of
//overall rating (opponent has ran away)
//○ Otherwise, if one of the fighters is 3 or more points of skill above their opponent, they
//win the fight regardless of overall rating
//○ The winner is the Transformer with the highest overall rating
//● In the event of a tie, both Transformers are considered destroyed
//● Any Transformers who don’t have a fight are skipped (i.e. if it’s a team of 2 vs. a team of 1,
//there’s only going to be one battle)
//● The team who eliminated the largest number of the opposing team is the winner
//Special rules:
//● Any Transformer named Optimus Prime or Predaking wins his fight automatically regardless of any other criteria
//● In the event either of the above face each other (or a duplicate of each other), the game immediately ends with all competitors destroyed

