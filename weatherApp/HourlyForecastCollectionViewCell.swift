//
//  HourlyForecastCollectionViewCell.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 17.03.22.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setupHorForcast(forcast: HourlyForecastWeatherModel) {
        self.hourLabel.text = DateService().getHour(fromDate: forcast.epochDateTime)
        self.tempLabel.text = String(forcast.temperature.value.int()) + "°"
        
        loadImage(forcast: forcast)
    }


    private func loadImage(forcast: HourlyForecastWeatherModel) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        NetworkService().downloadImage(imageID: forcast.weatherIcon) { [weak self] image in
            self?.weatherImageView.image = image
            
            self?.activityIndicator.isHidden = true
            self?.activityIndicator.stopAnimating()
        }
    }
    
    
}
