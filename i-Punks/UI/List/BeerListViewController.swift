
import UIKit
import RxSwift

class BeerListViewController: UIViewController {

    var viewModel: BeerListViewModel?
    
    let disposeBag = DisposeBag()
    let listDataSource = BeerListDataSource()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewBinding()
        viewModel?.fetchBeerList(page: 1)
    }

    private func setupViewBinding() {
        // tableView
        viewModel?.beerList
            .drive(tableView.rx.items(dataSource: listDataSource))
            .disposed(by: disposeBag)
        viewModel?.isLoading
            .drive(tableView.rx.isHidden)
            .disposed(by: disposeBag)

        // indicator
        viewModel?.isLoading
            .map { !$0 }
            .drive(indicatorView.rx.isHidden)
            .disposed(by: disposeBag)
    }

}
