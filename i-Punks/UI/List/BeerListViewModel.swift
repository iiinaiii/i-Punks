

import Foundation
import RxSwift
import RxCocoa

final class BeerListViewModel {
    let useCase: BeerUseCase
    
    let _isLoading = BehaviorRelay<Bool>(value: false)
    private lazy var _beerList = self.useCase.observeBeerList().do(
        onNext: { (_) in self._isLoading.accept(false) },
        onError: { (_) in self._isLoading.accept(false) }
    )

    lazy var isLoading = _isLoading.asDriver()
    lazy var beerList = _beerList.asDriver(onErrorDriveWith: Driver.empty())

    init(useCase: BeerUseCase) {
        self.useCase = useCase
    }

    func fetchBeerList(page: Int) {
        _isLoading.accept(true)
        useCase.fetchBeerList(page: page)
    }
}
