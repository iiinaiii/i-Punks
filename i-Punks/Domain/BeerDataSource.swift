
import Foundation
import RxSwift

protocol BeerDataSource {
    func searchBeer(page:Int) -> Single<Result<Beer, Error>>
}
