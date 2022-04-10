//
//  HourlyForecastCollectionViewCell.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 17.03.22.
//

import UIKit

final class HourlyForecastCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var hourLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var tempLabel: UILabel!
    
    func setupHorForcast(forcast: HourlyForecastWeatherModel) {
        self.hourLabel.text = DateService().getHour(fromDate: forcast.epochDateTime)
        self.tempLabel.text = String(forcast.temperature.value.int()) + "°"
        
        loadImage(forcast: forcast)
    }


    private func loadImage(forcast: HourlyForecastWeatherModel) {
        weatherImageView.image = nil
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        DownloadImageService().downloadImage(imageID: forcast.weatherIcon) { [weak self] image in
            self?.weatherImageView.image = image
            
            self?.activityIndicator.isHidden = true
            self?.activityIndicator.stopAnimating()
        }
    }
    
    
}
