//
//  ResultsViewModel.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 21.03.22.
//

import Foundation


protocol ResultsViewModelProtocol {
    
    var cities: [CityModel] { get }
    var locationCity: CityModel?  { get set }
    
    var didContentChanged: (() -> Void)? { get set }
    
    func loadCities(city: String)
    func saveEntity(for indexPath: IndexPath)
}


class ResultsViewModel: ResultsViewModelProtocol {
    
    var locationCity: CityModel? {
        didSet {
            addMyLocation(locationCity: locationCity)
        }
    }
    
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
        
        if isUnique(cityId: cities[indexPath.row].cityId) {
            
            
            let newEntity = CityEntity(context: CoreDataService.shared.managedObjectContext)
            newEntity.cityId = cities[indexPath.row].cityId
            newEntity.cityName = cities[indexPath.row].cityName
            
            networkDataForCity(cityId: cities[indexPath.row].cityId, cityEntity: newEntity)
            
            newEntity.country = cities[indexPath.row].country?.countryFullName
            CoreDataService.shared.saveContext()
        }
        
    }
    
    func addMyLocation(locationCity: CityModel?) {
        guard let locationCity = locationCity else { return}
        if isUnique(cityId: locationCity.cityId) {
            
            let myLocation = CityEntity(context: CoreDataService.shared.managedObjectContext)
            myLocation.cityName = locationCity.cityName
            myLocation.cityId = locationCity.cityId
            myLocation.country = locationCity.country?.countryFullName
            
            networkDataForCity(cityId: locationCity.cityId, cityEntity: myLocation)
            myLocation.myLocation = true
            CoreDataService.shared.saveContext()
        }
    }
    
    private func networkDataForCity(cityId: String, cityEntity: CityEntity) {
        networkService.getCurrentWeather(city: cityId) { currentWeather in
            cityEntity.currentTemp = currentWeather.first?.temperature.metric.value ?? 0
            cityEntity.weatherDescription = currentWeather.first?.weatherDescription
        }
        
        networkService.getDailyForcast(city: cityId) { dailyForcast in
            cityEntity.maxTemp = dailyForcast.dailyForecasts.first?.temperature.maxTemp.value ?? 0
            cityEntity.minTemp = dailyForcast.dailyForecasts.first?.temperature.minTemp.value ?? 0
        }
    }
    
    private func isUnique(cityId: String) -> Bool {
        let request = CityEntity.fetchRequest()
        request.predicate = NSPredicate(format: "cityId = %@", cityId)
        guard let result = try? CoreDataService.shared.managedObjectContext.fetch(request) else { return false }
        if result.isEmpty {
            return true
        }  else {
            return false
        }
    }
    
}
