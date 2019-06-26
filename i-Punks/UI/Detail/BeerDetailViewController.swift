import UIKit
import RxSwift

class BeerDetailViewController: UIViewController {

    static func newInstance(beerId: Int) -> BeerDetailViewController {
        let storyBoard = UIStoryboard(name: "BeerDetail", bundle: nil)
        let viewController = storyBoard.instantiateInitialViewController() as! BeerDetailViewController
        viewController.beerId = beerId
        return viewController
    }


    private var beerId: Int!
    var viewModel: BeerDetailViewModel?
    let disposeBag = DisposeBag()

    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!

    override func viewDidLoad() {
        setupViewBinding()
        viewModel?.fetchBeerDetail(beerId: beerId)
    }

    private func setupViewBinding() {
        // name
        viewModel?.beerName
            .drive(beerNameLabel.rx.text)
            .disposed(by: disposeBag)

        // tagline
        viewModel?.tagline
            .drive(taglineLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
