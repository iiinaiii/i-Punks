
import Foundation
import RxSwift
import Alamofire

class BeerApi: BeerDataSource {
    func searchBeerList(page: Int) -> Single<Result<Array<Beer>, Error>> {
        return Single<Result<Array<Beer>, Error>>.create { singleEvent in
            let request = AF.request("https://httpbin.org/get").responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    let beerResponseList = try? JSONDecoder().decode([BeerResponse].self, from: data as! Data)
                    if(beerResponseList == nil) {
                        singleEvent(.error(ApiError()))
                    } else {
                        let beerList = beerResponseList!.map({ $0.toBeer() })
                        singleEvent(.success(Result.success(beerList)))
                    }
                case .failure(_):
                    singleEvent(.error(ApiError()))
                }
            }
            return Disposables.create { request.cancel() }
        }
    }
}

class ApiError: Error {
}
