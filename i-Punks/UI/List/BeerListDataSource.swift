
import Foundation
import UIKit
import RxCocoa
import RxSwift

class BeerListDataSource: NSObject, UITableViewDataSource, RxTableViewDataSourceType {

    typealias Element = [Beer]
    var _beers: [Beer] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _beers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath)
        let beer = _beers[indexPath.row]

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
        return cell
    }

    func tableView(_ tableView: UITableView, observedEvent: Event<Element>) {
        Binder(self) { dataSource, beers in
            dataSource._beers = beers
            tableView.reloadData()
        }.on(observedEvent)
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
