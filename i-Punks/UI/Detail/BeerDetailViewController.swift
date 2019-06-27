import UIKit
import RxSwift

class BeerDetailViewController: UIViewController {

    static func createNavigationController(beerId: Int) -> UINavigationController {
        let storyBoard = UIStoryboard(name: "BeerDetail", bundle: nil)
        let nc = storyBoard.instantiateViewController(withIdentifier: "beerDetailNavigationController") as! UINavigationController
        (nc.topViewController as! BeerDetailViewController).beerId = beerId
        return nc
    }


    private var beerId: Int!
    var viewModel: BeerDetailViewModel?
    let disposeBag = DisposeBag()

    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var abvValue: UILabel!
    @IBOutlet weak var ibuValue: UILabel!
    @IBOutlet weak var ogValue: UILabel!

    override func viewDidLoad() {
        setupViewBinding()
        viewModel?.fetchBeerDetail(beerId: beerId)
    }

    private func setupViewBinding() {
        // image
        viewModel?.beerImageUrl
            .map { UIImage(url: $0) }
            .drive(beerImageView.rx.image)
            .disposed(by: disposeBag)

        // name
        viewModel?.beerName
            .drive(beerNameLabel.rx.text)
            .disposed(by: disposeBag)

        // tagline
        viewModel?.tagline
            .drive(taglineLabel.rx.text)
            .disposed(by: disposeBag)

        // abv/ibu/og
        viewModel?.abv
            .drive(abvValue.rx.text)
            .disposed(by: disposeBag)
        viewModel?.ibu
            .drive(ibuValue.rx.text)
            .disposed(by: disposeBag)
        viewModel?.og
            .drive(ogValue.rx.text)
            .disposed(by: disposeBag)
    }
}
