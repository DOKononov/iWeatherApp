//
//  LocationWeather.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 4.04.22.
//

import Foundation

struct LocationWeather: Codable {
    let cityId: String
//    let cityName: String
//    let country: AdministrativeArea
//    let geoPosition: GeoPosition
    
    enum CodingKeys: String, CodingKey {
        case cityId = "Key"
//        case cityName = "EnglishName"
//        case country = "Country"
//        case geoPosition = "GeoPosition"
//    }
}

//struct GeoPosition: Codable {
//    let latitude: Double
//    let longitude: Double
//
//    enum CodingKeys: String, CodingKey {
//        case latitude = "Latitude"
//        case longitude = "Longitude"
//    }
}



