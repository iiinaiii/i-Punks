

import Foundation
import RxSwift
import RxCocoa

final class BeerListViewModel {
    let useCase: BeerUseCase
    let beerList: Driver<Array<Beer>>

    init(useCase: BeerUseCase) {
        self.useCase = useCase
        beerList = self.useCase.observeBeerList()
            .asDriver(onErrorDriveWith: Driver.empty())
    }

    func fetchBeerList(page: Int) {
        useCase.fetchBeerList(page: page)
    }
}
