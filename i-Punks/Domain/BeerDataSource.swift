
import Foundation
import RxSwift

protocol BeerDataSource {
    func searchBeerList(page: Int) -> Single<Result<Array<Beer>, Error>>
}
