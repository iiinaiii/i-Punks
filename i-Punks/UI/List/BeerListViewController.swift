
import UIKit
import RxSwift

class BeerListViewController: UIViewController, BeerListNavigator {

    var viewModel: BeerListViewModel?

    let disposeBag = DisposeBag()
    lazy var listDataSource = BeerListDataSource(itemSelected: { beer in
        self.toBeerDetail(beerId: beer.id)
    })

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = listDataSource
        }
    }
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
        viewModel?.loadState
            .map { $0 != LoadState.complete }
            .drive(tableView.rx.isHidden)
            .disposed(by: disposeBag)

        // indicator
        viewModel?.loadState
            .map { $0 != LoadState.loading }
            .drive(indicatorView.rx.isHidden)
            .disposed(by: disposeBag)
    }

    func toBeerDetail(beerId: Int) {
//        let nc = BeerDetailViewController.createNavigationController(beerId: beerId)
//        present(nc, animated: true, completion: nil)
        let vc = BeerDetailViewController.createViewController(beerId: beerId)
        navigationController?.pushViewController(vc, animated: true)
    }

}
