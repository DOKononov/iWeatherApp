//
//  ForcastTableViewCell.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 7.03.22.
//

import UIKit

class DailyForcastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weakDayLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var weatherProgressView: UIProgressView!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var currentTemp = 0.0
    
    private lazy var dataService =  DateService()
    private lazy var networkService = NetworkService()
 
    
    func setup(dailyForcast: DailyForecast) {
        
        activityIndicator.isHidden = true
                
        networkService.downloadImage(imageID: dailyForcast.day.icon, complition: { [weak self] image in
            self?.weatherImageView.image = image
        })
        
        weakDayLabel.text = dataService.weekday(fromDate: dailyForcast.date)
        minTempLabel.text = String(dailyForcast.temperature.minTemp.value.int())
        maxTempLabel.text = String(dailyForcast.temperature.maxTemp.value.int())
        setupProgressView(dailyForcast: dailyForcast)
    }
    
    
    
    //TODO: setupProgressView
    private func setupProgressView(dailyForcast: DailyForecast) {
                
        if Float(dailyForcast.temperature.maxTemp.value) != 0 {
            weatherProgressView.progress = Float(currentTemp) / Float(dailyForcast.temperature.maxTemp.value)
        } else {
            weatherProgressView.progress = 0
        }
        
    }
    
    
}




