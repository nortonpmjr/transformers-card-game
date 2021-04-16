import Quick
import Nimble

@testable import TransformersCardGame

class BattlegroundTests: QuickSpec {

    override func spec() {
        let optimusPrime = TransformerModel(name: "Optimus Prime", strength: 10, intelligence: 10, speed: 8, endurance: 10, rank: 10, courage: 10, firepower: 8, skill: 10, team: .Autobot, id: "", teamIcon: "")

        let sunstreaker = TransformerModel(name: "Sunstreaker", strength: 5, intelligence: 6, speed: 7, endurance: 8, rank: 5, courage: 7, firepower: 7, skill: 6, team: .Autobot, id: "", teamIcon: "")

        let bumblebee = TransformerModel(name: "Bumblebee", strength: 2, intelligence: 8, speed: 4, endurance: 7, rank: 7, courage: 10, firepower: 1, skill: 5, team: .Autobot, id: "", teamIcon: "")

        let weakAutobot = TransformerModel(name: "Weak Autobot", strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1, team: .Autobot, id: "", teamIcon: "")

        let predaking = TransformerModel(name: "Predaking", strength: 10, intelligence: 5, speed: 10, endurance: 8, rank: 7, courage: 9, firepower: 9, skill: 8, team: .Decepticon, id: "", teamIcon: "")

        let reflector = TransformerModel(name: "Reflector", strength: 7, intelligence: 8, speed: 2, endurance: 6, rank: 6, courage: 7, firepower: 6, skill: 9, team: .Decepticon, id: "", teamIcon: "")

        let fangry = TransformerModel(name: "Fangry", strength: 6, intelligence: 8, speed: 6, endurance: 8, rank: 6, courage: 8, firepower: 6, skill: 8, team: .Decepticon, id: "", teamIcon: "")

        let weakDecepticon = TransformerModel(name: "Weakling Decepticon", strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1, team: .Decepticon, id: "", teamIcon: "")


        var sut: Battleground!

        describe("special rules") {
            context("when autobots have optimus prime") {
                it("win") {
                    sut = Battleground()
                    let tranformers: [TransformerModel] = [optimusPrime, sunstreaker, bumblebee, reflector]

                    let result: BattleResult = sut.startBattle(tranformers)

                    expect(result.battleCount).to(equal(1))
                    expect(result.winningTeam).to(equal(TransformerTeam.Autobot))
                }
            }
            context("when decepticons have predaking") {
                it("win") {
                    sut = Battleground()
                    let tranformers: [TransformerModel] = [predaking, sunstreaker, bumblebee]

                    let result: BattleResult = sut.startBattle(tranformers)

                    expect(result.battleCount).to(equal(1))
                    expect(result.winningTeam).to(equal(TransformerTeam.Decepticon))
                    expect(result.autobotSurvivors.count).to(equal(1))
                    expect(result.autobotSurvivors).to(contain(bumblebee))
                }
            }
            context("when Optimus Prime and Predaking face each other") {
                it("everyone loses") {
                    sut = Battleground()
                    let transformers: [TransformerModel] = [predaking, optimusPrime, bumblebee, sunstreaker]

                    let result = sut.startBattle(transformers)

                    expect(result.battleCount).to(equal(1))
                    expect(result.winningTeam).to(beNil())
                    expect(result.autobotSurvivors).to(beEmpty())
                    expect(result.decepticonSurvivors).to(beEmpty())
                }
            }

            context("when both teams have Optimus Prime") {
                it("kills everyone") {
                    sut = Battleground()
                    var decepticonOptimus = optimusPrime
                    decepticonOptimus.team = .Decepticon
                    let transformers: [TransformerModel] = [decepticonOptimus, optimusPrime]

                    let result = sut.startBattle(transformers)

                    expect(result.battleCount).to(equal(1))
                    expect(result.winningTeam).to(beNil())
                    expect(result.autobotSurvivors).to(beEmpty())
                    expect(result.decepticonSurvivors).to(beEmpty())
                }
            }

            context("when both teams have Predaking") {
                it("kills everyone") {
                    sut = Battleground()
                    var autobotPredaking = predaking
                    autobotPredaking.team = .Autobot
                    let transformers: [TransformerModel] = [predaking, autobotPredaking]

                    let result = sut.startBattle(transformers)

                    expect(result.battleCount).to(equal(1))
                    expect(result.winningTeam).to(beNil())
                    expect(result.autobotSurvivors).to(beEmpty())
                    expect(result.decepticonSurvivors).to(beEmpty())
                }
            }

            context("when predaking or optimus prime face each other or a duplicate of them") {
                it("kills everyone") {
                    sut = Battleground()
                    var decepticonOptimus = optimusPrime
                    decepticonOptimus.team = .Decepticon
                    var autobotPredaking = predaking
                    autobotPredaking.team = .Autobot
                    let transformers: [TransformerModel] = [predaking, autobotPredaking, decepticonOptimus, optimusPrime]

                    let result = sut.startBattle(transformers)

                    expect(result.battleCount).to(equal(1))
                    expect(result.winningTeam).to(beNil())
                    expect(result.autobotSurvivors).to(beEmpty())
                    expect(result.decepticonSurvivors).to(beEmpty())
                }
            }
        }

        describe("attributes rules") {
            context("when autobot courage is greater than 3 and autobot strength is greater than 4") {
                it("autobot wins") {
                    sut = Battleground()
                    let transformer: [TransformerModel] = [sunstreaker, weakDecepticon]

                    let result = sut.startBattle(transformer)

                    expect(result.battleCount).to(equal(1))
                    expect(result.winningTeam).to(equal(TransformerTeam.Autobot))
                }
            }

            context("when decepticon courage is greater than 3 and autobot strength is greater than 4") {
                it("autobot wins") {
                    sut = Battleground()
                    let transformer: [TransformerModel] = [weakAutobot, reflector]

                    let result = sut.startBattle(transformer)

                    expect(result.battleCount).to(equal(1))
                    expect(result.winningTeam).to(equal(TransformerTeam.Decepticon))
                }
            }

            context("when neither strength/courage rule apply") {
                it("decides using skill rule") {
                    sut = Battleground()
                    let transformer: [TransformerModel] = [bumblebee, fangry]

                    let result = sut.startBattle(transformer)

                    expect(result.battleCount).to(equal(1))
                    expect(result.winningTeam).to(equal(TransformerTeam.Decepticon))
                }
            }

            context("when neither strength/courage and skill rules apply") {
                it("decides using overall rating") {
                    sut = Battleground()
                    let transformer: [TransformerModel] = [sunstreaker, reflector]

                    let result = sut.startBattle(transformer)

                    expect(result.battleCount).to(equal(1))
                    expect(result.winningTeam).to(equal(TransformerTeam.Autobot))
                }
            }

            context("when it's a tie") {
                it ("kills everyone") {
                    sut = Battleground()
                    let transformers: [TransformerModel] = [weakAutobot, weakDecepticon]

                    let result = sut.startBattle(transformers)

                    expect(result.winningTeam).to(beNil())
                    expect(result.autobotSurvivors).to(beEmpty())
                    expect(result.decepticonSurvivors).to(beEmpty())
                }
            }
        }
    }
}
