import Foundation

class BeerUseCase {
    let repository:BeerRepository
    
    init(repository:BeerRepository) {
        self.repository = repository
    }
}
