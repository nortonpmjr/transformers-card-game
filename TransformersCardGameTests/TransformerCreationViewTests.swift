import Quick
import Nimble
import Nimble_Snapshots
import SnapKit
import SnapshotTesting

@testable import TransformersCardGame

class TransformersCreationViewTests: QuickSpec {

    override func spec() {
        var sut: TransformerCreationView!
        var view: UIViewController!

        beforeEach {
            sut = TransformerCreationView()
        }

        describe("#init") {
            it("has a valid Snapshot") {
                let devices: [String: ViewImageConfig] = ["iPhoneX": .iPhoneX, "iPhoneSE": .iPhoneSe, "iPhoneXsMax": .iPhoneXsMax]
                view = UIViewController()
                view.view.addSubview(sut)
                sut.bindFrameToSuperviewBounds()
                sut.setup()
                sut.maxWidth = 100
                devices.map { device in
                    assertSnapshot(matching: view, as: .image(on: device.value), named: device.key)
                }
            }
        }
    }
}
