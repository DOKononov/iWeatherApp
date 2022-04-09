//
//  CityTableViewCell.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 24.03.22.
//

import UIKit

final class CityTableViewCell: UITableViewCell {

    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var weatherConditionsLabel: UILabel!
    @IBOutlet private weak var currentTempLabel: UILabel!
    @IBOutlet private weak var higLowTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
    
    func setupCell(city: CityEntity) {
        cityLabel.text = city.cityName
        weatherConditionsLabel.text = city.weatherDescription
        currentTempLabel.text = "\(city.currentTemp.int())°"
        let maxTemp = "H:\(city.maxTemp.int())°"
        let minTemp = "L:\(city.minTemp.int())°"
        higLowTempLabel.text = maxTemp + " " + minTemp
        countryLabel.text = city.country
    }

}
