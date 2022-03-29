//
//  CityEntity+CoreDataProperties.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 27.03.22.
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
    @NSManaged public var currentTemp: Double
    @NSManaged public var maxTemp: Double
    @NSManaged public var minTemp: Double
    @NSManaged public var weatherDescription: String?

}

extension CityEntity : Identifiable {

}
