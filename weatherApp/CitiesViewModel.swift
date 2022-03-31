//
//  CitiesViewModel.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 24.03.22.
//

import Foundation
import CoreData

protocol CitiesViewModelProtocol {
    
    var fetchResultCotroller: NSFetchedResultsController<CityEntity>! { get }
    var citiesArray: [CityEntity] { get }
    
    var didContentChanged: (() -> Void)?  { get set }
    
    func loadCitiesFromeCoreData()
    func updateCitiesData()
    func setupFetchResultController()
    
}


final class CitiesViewModel: NSObject, CitiesViewModelProtocol, NSFetchedResultsControllerDelegate {
    
    var fetchResultCotroller: NSFetchedResultsController<CityEntity>!
    
    var citiesArray: [CityEntity] = [] {
        didSet {
            didContentChanged?()
        }
    }
    
    var didContentChanged: (() -> Void)?
    
    func loadCitiesFromeCoreData() {
        
        let request = CityEntity.fetchRequest()
        if let result = try? CoreDataService.shared.managedObjectContext.fetch(request) {
            citiesArray = result
        }
        
        setupFetchResultController()
        try? fetchResultCotroller.performFetch()
        if let result = fetchResultCotroller.fetchedObjects {
            citiesArray = result
        }
    }
    
    
    func setupFetchResultController() {
        let request = CityEntity.fetchRequest()
        let descriptor = NSSortDescriptor(key: "cityName", ascending: true)
        request.sortDescriptors = [descriptor]

        fetchResultCotroller = NSFetchedResultsController(fetchRequest: request,
                                                          managedObjectContext: CoreDataService.shared.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultCotroller.delegate = self
    }
  
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        loadCitiesFromeCoreData()
    }
    
    
    func updateCitiesData() {
        citiesArray.forEach { city in
            
            guard let id = city.cityId else {return}
            
            NetworkService().getDailyForcast(city: id) { dailyForcast in
                city.maxTemp = dailyForcast.dailyForecasts.first?.temperature.maxTemp.value ?? 0
                city.minTemp = dailyForcast.dailyForecasts.first?.temperature.minTemp.value ?? 0
            }
            NetworkService().getCurrentWeather(city: id) { currentWeather in
                city.currentTemp = currentWeather.first?.temperature.metric.value ?? 0
                city.weatherDescription = currentWeather.first?.weatherDescription
                
            }
        }
    }
    
}


