//
//  ResultsViewModel.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 21.03.22.
//

protocol ResultsViewModelProtocol {
    
    var cities: [CityModel] { get }
    
    var didContentChanged: (() -> Void)? { get set }
    
    func loadCities(city: String)
}


class ResultsViewModel: ResultsViewModelProtocol {
    
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
    
    
}
