//
//  ResultTableViewCell.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 21.03.22.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    

    func setupCell(city: CityModel) {
        cityLabel.text = city.cityName
        countryLabel.text = city.country.countryFullName
    }
    
}
