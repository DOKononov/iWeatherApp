//
//  HourlyForecastWeatherModel:.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 16.03.22.
//

import Foundation

struct HourlyForecastWeatherModel: Codable {
    let epochDateTime, weatherIcon: Int
    let iconPhrase: String
    let temperature: DailyTemperature

    enum CodingKeys: String, CodingKey {
        case epochDateTime = "EpochDateTime"
        case weatherIcon = "WeatherIcon"
        case iconPhrase = "IconPhrase"
        case temperature = "Temperature"
    }
}

struct DailyTemperature: Codable {
    let value: Double

    enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
}




