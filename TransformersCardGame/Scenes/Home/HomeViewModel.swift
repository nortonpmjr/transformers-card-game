import Foundation

protocol HomeViewModelDelegateType {
    func transformersUpdated(_ transformers: [TransformerModel])
    func finishedBattle(result: BattleResult)
}

class HomeViewModel {

    var transformers: [TransformerModel]
    var viewDelegate: HomeViewModelDelegateType?

    var transformersUpdatedCallback: (() -> Void)?

    init() {
        TransformerRepository.shared.getToken()
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

    func calculateBattle() {
        guard transformers.count > 0 else { return }
        let result = Battleground.shared.startBattle(transformers)
        viewDelegate?.finishedBattle(result: result)
    }
}
