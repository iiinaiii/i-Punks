import Foundation
import RxSwift

class BeerUseCase {
    let repository: BeerRepository

    init(repository: BeerRepository) {
        self.repository = repository
    }

    func fetchBeerList(page: Int) {
        repository.fetchBeerList(page: page)
    }

    func observeBeerList() -> Observable<Array<Beer>> {
        repository.observeBeerList()
    }
}
