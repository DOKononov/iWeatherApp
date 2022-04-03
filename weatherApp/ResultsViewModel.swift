//
//  ResultsViewModel.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 21.03.22.
//

import Foundation

protocol ResultsViewModelProtocol {
    
    var cities: [CityModel] { get }
    
    var didContentChanged: (() -> Void)? { get set }
    
    func loadCities(city: String)
    func saveEntity(for indexPath: IndexPath)
}


class ResultsViewModel: ResultsViewModelProtocol {
    lazy var networkService = NetworkService()
    
    var cities: [CityModel] = [] {
        didSet {
            didContentChanged?()
        }
    }
    
    var didContentChanged: (() -> Void)?
    
    func loadCities(city: String) {
        NetworkService().getLocationAutocomplete(city: city) { cities in
            self.cities = cities
        }
    }
    
    
    //MARK: -save city to coreData
     func saveEntity(for indexPath: IndexPath) {
        let newEntity = CityEntity(context: CoreDataService.shared.managedObjectContext)
        newEntity.cityId = cities[indexPath.row].cityId
        newEntity.cityName = cities[indexPath.row].cityName
        
        networkService.getCurrentWeather(city: cities[indexPath.row].cityId) { currentWeather in
            newEntity.currentTemp = currentWeather.first?.temperature.metric.value ?? 0
            newEntity.weatherDescription = currentWeather.first?.weatherDescription
        }
        
        networkService.getDailyForcast(city: cities[indexPath.row].cityId) { dailyForcast in
            newEntity.maxTemp = dailyForcast.dailyForecasts.first?.temperature.maxTemp.value ?? 0
            newEntity.minTemp = dailyForcast.dailyForecasts.first?.temperature.minTemp.value ?? 0
        }
        newEntity.country = cities[indexPath.row].country.countryFullName
        
        CoreDataService.shared.saveContext()
    }
}
