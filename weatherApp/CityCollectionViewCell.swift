//
//  CityCollectionViewCell.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 20.03.22.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherConditionsLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var higLowTempLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
    
    
    func setupCell(city: CityEntity) {
        cityLabel.text = city.cityName
        
    }

}
