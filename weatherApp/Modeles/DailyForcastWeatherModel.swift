//
//  DailyForcastWeatherModel.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 10.03.22.
//

import Foundation

struct DailyForcastWeatherModel: Codable {
    let dailyForecasts: [DailyForecast]

    enum CodingKeys: String, CodingKey {
        case dailyForecasts = "DailyForecasts"
    }
}

struct DailyForecast: Codable {
    let date: Int
    let temperature: Temperature
    let day, night: Day

    enum CodingKeys: String, CodingKey {
        case date = "EpochDate"
        case temperature = "Temperature"
        case day = "Day"
        case night = "Night"
    }
}

struct Day: Codable {
    let icon: Int
    let iconPhrase: String

    enum CodingKeys: String, CodingKey {
        case icon = "Icon"
        case iconPhrase = "IconPhrase"
    }
}

struct Temperature: Codable {
    let minTemp, maxTemp: Imum

    enum CodingKeys: String, CodingKey {
        case minTemp = "Minimum"
        case maxTemp = "Maximum"
    }
}

struct Imum: Codable {
    let value: Double

    enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
}



