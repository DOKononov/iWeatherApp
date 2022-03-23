//
//  CityCoreDataModel.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 22.03.22.
//

import Foundation

final class CityCoreDataModel {
    
    let cityId: String
    let cityName: String
    let currentTemp: Double
    let weatherDescription: String
    let minTemp: Double
    let maxTemp: Double
    
    init(cityId: String, cityName: String, currentTemp: Double, weatherDescription: String, minTemp: Double, maxTemp: Double) {
        self.cityId = cityId
        self.cityName = cityName
        self.currentTemp = currentTemp
        self.weatherDescription = weatherDescription
        self.minTemp = minTemp
        self.maxTemp = maxTemp
    }
    
}
