
import Foundation

struct BeerResponse: Codable {
    let id: Int
    let name: String
    let tagline: String
    let first_brewed: String?
    let description: String
    let image_url: String
    let abv: Float?
    let ibu: Float?
    let target_fg: Float?
    let target_og: Float?
    let ebc: Float?
    let srm: Float?
    let volume: VolumeResponse
    let boil_volume: VolumeResponse
    let ph: Float?
    let attenuation_level: Float?
    let food_pairing: [String]
    let brewers_tips: String
}

extension BeerResponse {
    func toBeer() -> Beer {
        return Beer(
            id: id,
            name: name,
            tagline: tagline,
            firstBrewed: convertDate(inDateStr: first_brewed),
            description: description,
            imageUrl: image_url,
            abv: "\(abv.toStringOrDefault())%",
            ibu: "\(ibu.toStringOrDefault())%",
            targetOg: target_og.toStringOrDefault(),
            targetFg: target_fg.toStringOrDefault(),
            ebc: ebc.toStringOrDefault(),
            srm: srm.toStringOrDefault(),
            volume: "\(volume.value)\(volume.unit)",
            boilVolume: "\(boil_volume.value)\(boil_volume.unit)",
            ph: ph.toStringOrDefault(),
            attenuationLevel: attenuation_level.toStringOrDefault(),
            foodPairing: food_pairing,
            brewersTips: brewers_tips)
    }
}

private extension Optional where Wrapped == Float {
    func toStringOrDefault() -> String {
        return self?.description ?? "-"
    }
}

private func convertDate(inDateStr: String?) -> String {
    guard let dateStr = inDateStr else {
        return "-"
    }

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/yyyy"
    guard let date = dateFormatter.date(from: dateStr) else {
        return "-"
    }

    dateFormatter.dateFormat = "MMMM yyyy"
    return dateFormatter.string(from: date).uppercased()
}
