import Foundation

class BeerRepository {
    let dataSource :BeerDataSource
    
    init(dataSource:BeerDataSource) {
        self.dataSource = dataSource
    }
}
