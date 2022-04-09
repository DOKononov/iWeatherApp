//
//  CityEntity+CoreDataProperties.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 8.04.22.
//
//

import Foundation
import CoreData


extension CityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "CityEntity")
    }

    @NSManaged public var cityId: String?
    @NSManaged public var cityName: String?
    @NSManaged public var country: String?
    @NSManaged public var currentTemp: Double
    @NSManaged public var maxTemp: Double
    @NSManaged public var minTemp: Double
    @NSManaged public var weatherDescription: String?
    @NSManaged public var myLocation: Bool

}

extension CityEntity : Identifiable {

}
