
import Foundation
import RxSwift
import Alamofire

class BeerApi: BeerDataSource {
    func searchBeerList(page: Int) -> Single<Result<Array<Beer>, Error>> {
        return Single<Result<Array<Beer>, Error>>.create { singleEvent in
            let request = AF.request("https://api.punkapi.com/v2/beers",
                method: .get,
                parameters: ["page": page])
                .responseDecodable { (response: DataResponse<[BeerResponse]>) in
                    switch response.result {
                    case .success(let beerResponseList):
                        let beerList = beerResponseList.map({ $0.toBeer() })
                        singleEvent(.success(Result.success(beerList)))
                    case .failure(let error):
                        print("failure: \(error)")
                        singleEvent(.error(ApiError()))
                    }
            }
            return Disposables.create { request.cancel() }
        }
    }
}

class ApiError: Error {
}
