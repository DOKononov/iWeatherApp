//
//  CurrentWeatherModel.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 12.03.22.
//

import Foundation

//struct CurrentWeatherModel: Codable {
//    let localObservationDateTime: Date
//    let epochTime: Int
//    let weatherText: String
//    let weatherIcon: Int
//    let isDayTime: Bool
//    let currentTemp: CurrentTemp
//
//    enum CodingKeys: String, CodingKey {
//        case localObservationDateTime = "LocalObservationDateTime"
//        case epochTime = "EpochTime"
//        case weatherText = "WeatherText"
//        case weatherIcon = "WeatherIcon"
//        case isDayTime = "IsDayTime"
//        case currentTemp = "Temperature"
//    }
//}
//
//struct CurrentTemp: Codable {
//    let metric: Imperial
//
//    enum CodingKeys: String, CodingKey {
//        case metric = "Metric"
//    }
//}
//
//struct Imperial: Codable {
//    let value: Double
//    let unit: String
//    let unitType: Int
//
//    enum CodingKeys: String, CodingKey {
//        case value = "Value"
//        case unit = "Unit"
//        case unitType = "UnitType"
//    }
//}




struct CurrentWeatherModel: Codable {
    let weatherText: String
    let weatherIcon: Int
    let isDayTime: Bool
    let temperature: CurrentTemp

    enum CodingKeys: String, CodingKey {
        case weatherText = "WeatherText"
        case weatherIcon = "WeatherIcon"
        case isDayTime = "IsDayTime"
        case temperature = "Temperature"
    }
}

struct CurrentTemp: Codable {
    let metric: Metric

    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
    }
}

// MARK: - Metric
struct Metric: Codable {
    let value: Double
    let unit: String

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
    }
}


