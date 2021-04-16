protocol HomeViewModelDelegateType {
    func transformersUpdated(_ transformers: [TransformerModel])
    func finishedBattle(result: BattleResult)
}
