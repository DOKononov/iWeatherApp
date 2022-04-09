//
//  MainViewModel.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 15.03.22.
//

import CoreLocation

protocol MainViewModelProtocol {
    
    var city: CityCoreDataModel? { get set }
    var dailyForecasts: [DailyForecast] { get }
    var currentWeather: [CurrentWeatherModel] { get }
    var hourlyForcast: [HourlyForecastWeatherModel] { get }
    
    var didContentChanged: (() -> Void)?  { get set }
    
    func loadWeather(id: String?)
    func loadLocalWeather(lat: CLLocationDegrees, lon: CLLocationDegrees)
    func setupLocationManager()
}


final class MainViewModel: NSObject, MainViewModelProtocol {
    
    private lazy var locationManager = CLLocationManager()
    private lazy var networkService = NetworkService()
    
    var city: CityCoreDataModel? 

    var dailyForecasts: [DailyForecast] = [] {
        didSet {
            didContentChanged?()
        }
    }
    
    var currentWeather: [CurrentWeatherModel] = [] {
        didSet {
            didContentChanged?()
        }
    }
    
    var hourlyForcast: [HourlyForecastWeatherModel] = [] {
        didSet {
            didContentChanged?()
        }
    }

    
    var didContentChanged: (() -> Void)?
    
    func loadWeather(id: String?) {
        guard let id = id else {  return }
            loadCurrentWeather(cityId: id)
            loadDailyForcast(cityId: id)
            loadHourlyForcast(cityId: id)
    }
    
}


extension MainViewModel {

    func loadCurrentWeather(cityId: String) {
        networkService.getCurrentWeather(city: cityId) { [weak self] currentWeather in
            self?.currentWeather = currentWeather
        }
    }
    
    func loadDailyForcast(cityId: String) {
        networkService.getDailyForcast(city: cityId) { [weak self] dailyForcastWeather in
            self?.dailyForecasts = dailyForcastWeather.dailyForecasts
        }
    }
    
    func loadHourlyForcast(cityId: String) {
        networkService.getHourlyForcast(city: cityId) { [weak self] hourlyForcast in
            self?.hourlyForcast = hourlyForcast
        }
    }
    
    func loadLocalWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        networkService.getWeatherForLocation(lat: lat.string(), lon: lon.string()) { city in
            self.loadWeather(id: city.cityId)
            
            let resultVC = ResultsVC(nibName: "\(ResultsVC.self)", bundle: nil)
            resultVC.viewModel.locationCity = city
        }
    }
}


extension MainViewModel: CLLocationManagerDelegate {
    
    func setupLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
               loadLocalWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
                locationManager.stopUpdatingLocation()
            }
    }
    
}
