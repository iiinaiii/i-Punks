
import UIKit
import RxSwift

class BeerListViewController: UIViewController {

    let disposeBag = DisposeBag()
    var viewModel: BeerListViewModel?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewBinding()
        viewModel?.fetchBeerList(page: 1)
    }

    private func setupViewBinding() {
        viewModel?.beerList
            .drive(tableView.rx.items(cellIdentifier: "beerCell")) { (_, beer, cell) in
                // image
                if let imageUrl = beer.imageUrl {
                    let imageView = cell.viewWithTag(1) as! UIImageView
                    imageView.image = self.getImageByUrl(url: imageUrl)
                }

                // name
                let nameLabel = cell.viewWithTag(2) as! UILabel
                nameLabel.text = beer.name

                // first brewed
                let brewedLabel = cell.viewWithTag(3) as! UILabel
                brewedLabel.text = beer.firstBrewed

                // abv
                let abvLabel = cell.viewWithTag(4) as! UILabel
                abvLabel.text = beer.abv
            }.disposed(by: disposeBag)

        viewModel?.isLoading
            .drive(
                onNext: { (isLoading) in
                    self.indicatorView.isHidden = !isLoading
                    self.tableView.isHidden = isLoading
                })
            .disposed(by: disposeBag)
    }

    private func getImageByUrl(url: String) -> UIImage {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        return UIImage()
    }

}
