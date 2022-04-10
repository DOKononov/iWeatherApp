//
//  CurrentWeatherTableViewCell.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 11.03.22.
//

import UIKit

final class CurrentWeatherTableViewCell: UITableViewCell {
    
    static let rowHeight: CGFloat = 200
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var currentTempLabel: UILabel!
    @IBOutlet private weak var weatherDescription: UILabel!
    @IBOutlet private weak var highLowTepmpLabel: UILabel!
    
    func setupCellWith(currentWeather: CurrentWeatherModel?, dailyForcast: [DailyForecast], cityName: String?) {
        if let currentWeather = currentWeather {
            currentTempLabel.text = "\(currentWeather.temperature.metric.value.int())°"
        }
        
        let minTemp = dailyForcast.first?.temperature.minTemp.value
        let maxTemp = dailyForcast.first?.temperature.maxTemp.value
        if let minTemp = minTemp, let maxTemp = maxTemp {
            highLowTepmpLabel.text = "H: \(maxTemp.int())° L:\(minTemp.int())°"
        }
        weatherDescription.text = currentWeather?.weatherDescription
        
        if let cityName = cityName {
            cityLabel.text = cityName
        }
        
    }
    
}
