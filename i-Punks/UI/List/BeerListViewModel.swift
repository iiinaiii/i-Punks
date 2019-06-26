
import Foundation
import RxSwift
import RxCocoa

final class BeerListViewModel {
    let useCase: BeerUseCase

    private let _loadState = BehaviorRelay<LoadState>(value: LoadState.preload)
    lazy var loadState = _loadState.asDriver()

    private lazy var _beerList = self.useCase.observeBeerList().do(
        onNext: { (_) in self._loadState.accept(LoadState.complete) },
        onError: { (_) in self._loadState.accept(LoadState.error) }
    )
    lazy var beerList: Driver<Array<Beer>> = _beerList
        .map { result in
            switch result {
            case .success(let beerList):
                return beerList
            case .failure(let error):
                throw error
            }
        }.asDriver(onErrorRecover: { error in
            self._loadState.accept(LoadState.error)
            return Driver<Array<Beer>>.empty()
        })

    init(useCase: BeerUseCase) {
        self.useCase = useCase
    }

    func fetchBeerList(page: Int) {
        _loadState.accept(LoadState.loading)
        useCase.fetchBeerList(page: page)
    }
}
