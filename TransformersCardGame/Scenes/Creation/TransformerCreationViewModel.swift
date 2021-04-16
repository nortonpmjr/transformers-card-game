import Foundation

protocol TransformerCreationViewModelDelegateType {
    func transformerCreated()
    func trasnformerToEdit(_ transformer: TransformerModel)
}

class TransformerCreationViewModel {

    var delegate: TransformerCreationViewModelDelegateType?
    var transformer: TransformerModel?
    init() {}

    func createTransformers(_ transformer: TransformerModel) {
        TransformerRepository.shared.createTransformer(transformer: transformer) { [weak self] in
            self?.delegate?.transformerCreated()
        }
    }

    func editTransformers(_ transformer: TransformerModel) {
        guard var t = self.transformer else { return }
        let id = t.id
        t = transformer
        t.id = id

        TransformerRepository.shared.editTransformer(t) { [weak self] in
            self?.delegate?.transformerCreated()
        }
    }

    func wantsToEdit() {
        guard let t = self.transformer else { return }
        delegate?.trasnformerToEdit(t)
    }
}
