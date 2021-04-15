import Foundation

class TransformerCreationViewModel {

    var delegate: TransformerCreationViewModelDelegateType?
    var transformer: TransformerModel

    init() {
        transformer = TransformerModel()
    }

    func createTransformers(_ transformer: TransformerModel) {
        TransformerRepository.shared.createTransformer(transformer: transformer) { [weak self] in
            self?.delegate?.transformerCreated()
        }
    }
}
