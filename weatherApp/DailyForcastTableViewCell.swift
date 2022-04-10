//
//  ForcastTableViewCell.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 7.03.22.
//

import UIKit

final class DailyForcastTableViewCell: UITableViewCell {
    
    static let rowHeight: CGFloat = 50
    
    @IBOutlet private weak var weakDayLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var minTempLabel: UILabel!
    @IBOutlet private weak var weatherProgressView: UIProgressView!
    @IBOutlet private weak var maxTempLabel: UILabel!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
        
    private lazy var dataService =  DateService()
    private lazy var networkService = NetworkService()
 
    func setup(dailyForcast: DailyForecast, currentTemp: Double) {
        
        weatherImageView.image = nil
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
                
        DownloadImageService().downloadImage(imageID: dailyForcast.day.icon, complition: { [weak self] image in
            self?.weatherImageView.image = image
            self?.activityIndicator.isHidden = true
            self?.activityIndicator.stopAnimating()
        })
        
        weakDayLabel.text = dataService.getWeekday(fromDate: dailyForcast.date)
        minTempLabel.text = String(dailyForcast.temperature.minTemp.value.int())
        maxTempLabel.text = String(dailyForcast.temperature.maxTemp.value.int())
        setupProgressView(dailyForcast: dailyForcast, currentTemp: currentTemp)
    }
    
    private func setupProgressView(dailyForcast: DailyForecast, currentTemp: Double) {
        let maxTemp = Float(dailyForcast.temperature.maxTemp.value)
        let minTemp = Float(dailyForcast.temperature.minTemp.value)
        let tempDiff =  maxTemp - minTemp
        weatherProgressView.progress = Float(currentTemp) / tempDiff
    }
 
}




