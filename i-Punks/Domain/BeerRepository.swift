import Foundation
import RxSwift

class BeerRepository {
    let dataSource: BeerDataSource

    let disposeBag = DisposeBag()

    private var beerCache: [Int: Beer] = [:]
    private let beerListSubject = PublishSubject<Result<Array<Beer>, Error>>()
    private let beerDetailSubject = PublishSubject<Result<Beer, Error>>()

    init(dataSource: BeerDataSource) {
        self.dataSource = dataSource
    }

    func fetchBeerList(page: Int) {
        dataSource.searchBeerList(page: page)
            .subscribeOn(SerialDispatchQueueScheduler(qos: .default))
            .subscribe(
                onSuccess: { result in
                    switch result {
                    case .success(let beerList):
                        self.cache(beerList: beerList)
                    case .failure(_):
                        break
                    }
                    self.beerListSubject.onNext(result)
                },
                onError: { error in
                    self.beerListSubject.onNext(Result.failure(error))
                }).disposed(by: disposeBag)
    }

    func fetchBeerDetail(beerId: Int) {
        if let beer = beerCache[beerId] {
            beerDetailSubject.onNext(Result.success(beer))
        } else {
            beerDetailSubject.onNext(Result.failure(PunksError.detailError))
        }
    }

    func observeBeerList() -> Observable<Result<Array<Beer>, Error>> {
        return beerListSubject.asObservable()
    }

    func observeBeerDetail() -> Observable<Result<Beer, Error>> {
        return beerDetailSubject.asObservable()
    }

    private func cache(beerList: Array<Beer>) {
        beerList.forEach { beer in
            self.beerCache[beer.id] = beer
        }
    }
}
