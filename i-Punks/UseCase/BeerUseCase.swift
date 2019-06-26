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

    func fetchBeerDetail(beerId: Int) {
        repository.fetchBeerDetail(beerId: beerId)
    }

    func observeBeerDetail() -> Observable<Result<Beer, Error>> {
        repository.observeBeerDetail()
    }

    func observeBeerList() -> Observable<Result<Array<Beer>, Error>> {
        repository.observeBeerList()
    }
}
