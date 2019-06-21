
import Foundation
import RxSwift
import Alamofire

class BeerApi: BeerDataSource {
    func searchBeer(page: Int) -> Single<Result<Beer,Error>> {
        return Single<Result<Beer,Error>>.create{ singleEvent in
            let request = AF.request("https://httpbin.org/get").responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    let beerResponse = try? JSONDecoder().decode(BeerResponse.self, from: data as! Data)
                    if(beerResponse == nil){
                        singleEvent(.error(ApiError()))
                    }else{
                        singleEvent(.success(Result.success(beerResponse!.toBeer())))
                    }
                case .failure( _):
                    singleEvent(.error(ApiError()))
                }
            }
            return Disposables.create { request.cancel() }
        }
    }
}

class ApiError: Error {
}
