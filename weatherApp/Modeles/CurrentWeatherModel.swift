//
//  CurrentWeatherModel.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 12.03.22.
//

import Foundation

struct CurrentWeatherModel: Codable {
    let weatherDescription: String
    let weatherIcon: Int
    let isDayTime: Bool
    let temperature: CurrentTemp

    enum CodingKeys: String, CodingKey {
        case weatherDescription = "WeatherText"
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


