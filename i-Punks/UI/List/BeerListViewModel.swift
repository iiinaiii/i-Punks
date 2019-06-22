

import Foundation
import RxSwift

final class BeerListViewModel{
    let useCase : BeerUseCase
    
    
    init(useCase:BeerUseCase) {
        self.useCase = useCase
    }
    
    func log() -> Void {
        print("test test test")
    }
}
