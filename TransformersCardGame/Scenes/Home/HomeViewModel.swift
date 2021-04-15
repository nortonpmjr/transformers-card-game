import Foundation

class HomeViewModel {


    var transformers: [TransformerModel]
    var viewDelegate: HomeViewModelDelegateType?

    var transformersUpdatedCallback: (() -> Void)?

    init() {
        TransformerRepository.shared.getToken() // call in another place

        transformers = []
    }

    func getTransformersList() {
        TransformerRepository.shared.getTransformersCallback = { [weak self] transformers in
            guard let strongSelf = self else { return }
            strongSelf.transformers = transformers
            strongSelf.viewDelegate?.transformersUpdated(transformers)
        }

        TransformerRepository.shared.getTransformers()
    }

    func deleteTransformer(_ transformer: TransformerModel) {
        TransformerRepository.shared.deleteTransformer(transformer) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.getTransformersList()
        }
    }

    func editTransformer(_ transformer: TransformerModel) {

    }
}
