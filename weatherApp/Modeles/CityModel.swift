//
//  CityModel.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 21.03.22.
//

import Foundation

struct CityModel: Codable {
    let cityId: String
    let cityName: String
    let country: AdministrativeArea
    
    enum CodingKeys: String, CodingKey {
        case cityId = "Key"
        case cityName = "LocalizedName"
        case country = "Country"
    }
}

struct AdministrativeArea: Codable {
    let countryTag: String
    let countryFullName: String
    
    enum CodingKeys: String, CodingKey {
        case countryTag = "ID"
        case countryFullName = "LocalizedName"
    }
}



