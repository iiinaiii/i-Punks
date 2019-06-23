
import UIKit
import RxSwift

class BeerListViewController: UIViewController {

    var viewModel: BeerListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .blue
        viewModel?.fetchBeerList(page: 0)
    }
}

