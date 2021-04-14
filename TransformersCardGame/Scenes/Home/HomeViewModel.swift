import Foundation

class HomeViewModel {

    let repository: TransformerRepository
    var transformers: [TransformerModel]
    var viewDelegate: HomeViewModelDelegateType?

    var transformersUpdatedCallback: (() -> Void)?

    init() {
        repository = TransformerRepository()
        repository.getToken() // call in another place

        transformers = []
    }

    func getTransformersList() {
        repository.getTransformersCallback = { [weak self] transformers in
            guard let strongSelf = self else { return }
            strongSelf.transformers = transformers
            strongSelf.viewDelegate?.transformersUpdated(transformers)
        }

        repository.getTransformers()
    }
}
