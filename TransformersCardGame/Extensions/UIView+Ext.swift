import SnapKit
import Foundation

extension UIView {
    func bindFrameToSuperviewBounds() {
        guard self.superview != nil else {
            print("Error! `superview` was nil " +
                "call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this")
            return
        }

        snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
