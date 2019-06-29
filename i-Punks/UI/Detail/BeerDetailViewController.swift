import UIKit
import RxSwift

class BeerDetailViewController: UIViewController, BeerDetailNavigator {

    static func createViewController(beerId: Int) -> UIViewController {
        let storyBoard = UIStoryboard(name: "BeerDetail", bundle: nil)
        let nc = storyBoard.instantiateViewController(withIdentifier: "beerDetailNavigationController") as! UINavigationController
        let vc = (nc.topViewController as! BeerDetailViewController)
        vc.beerId = beerId
        return vc
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
    @IBOutlet weak var beerDescriptionBody: UILabel!
    @IBOutlet weak var foodPairingBody: UILabel!
    @IBOutlet weak var brewersTips: UILabel!

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
        viewModel?.beerName
            .drive(navigationItem.rx.title)
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

        // description
        viewModel?.description
            .drive(beerDescriptionBody.rx.text)
            .disposed(by: disposeBag)

        // food pairing
        viewModel?.foodPairing
            .drive(foodPairingBody.rx.text)
            .disposed(by: disposeBag)

        // brewer's tips
        viewModel?.brewersTips
            .drive(brewersTips.rx.text)
            .disposed(by: disposeBag)
    }

    func backPage() {
        navigationController?.popViewController(animated: true)
    }
}
