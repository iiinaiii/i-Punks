
import Foundation
import RxSwift
import RxCocoa

final class BeerDetailViewModel {
    let useCase: BeerUseCase

    private let _loadState = BehaviorRelay<LoadState>(value: LoadState.preload)
    lazy var loadState = _loadState.asDriver()

    private lazy var _beerDetail: Observable<Beer> = self.useCase.observeBeerDetail()
        .do(onNext: { (_) in self._loadState.accept(LoadState.complete) },
            onError: { (_) in self._loadState.accept(LoadState.error) })
        .map { result in
            switch result {
            case .success(let beerDetail):
                return beerDetail
            case .failure(let error):
                throw error
            }
    }
    lazy var beerName: Driver<String> = _beerDetail.map { $0.name }
        .asDriver(onErrorDriveWith: Driver.empty())
    lazy var tagline: Driver<String> = _beerDetail.map { $0.tagline }
        .asDriver(onErrorDriveWith: Driver.empty())

    init(useCase: BeerUseCase) {
        self.useCase = useCase
    }

    func fetchBeerDetail(beerId: Int) {
        useCase.fetchBeerDetail(beerId: beerId)
    }
}
