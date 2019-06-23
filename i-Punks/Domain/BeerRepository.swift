import Foundation
import RxSwift

class BeerRepository {
    let dataSource: BeerDataSource
    let disposeBag = DisposeBag()
    private let beerListSubject = PublishSubject<Array<Beer>>()

    init(dataSource: BeerDataSource) {
        self.dataSource = dataSource
    }

    func fetchBeerList(page: Int) {
        dataSource.searchBeerList(page: page)
            .subscribeOn(SerialDispatchQueueScheduler(qos: .default))
            .subscribe(onSuccess: { result in
                switch result {
                case .success(let beerList):
                    self.beerListSubject.onNext(beerList)
                case .failure(let error):
                    self.beerListSubject.onError(error)
                }
            }, onError: { error in
                    self.beerListSubject.onError(error)
                }).disposed(by: disposeBag)
    }

    func observeBeerList() -> Observable<Array<Beer>> {
        return beerListSubject.asObservable()
    }
}
