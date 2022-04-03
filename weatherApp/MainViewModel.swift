//
//  MainViewModel.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 15.03.22.
//

protocol MainViewModelProtocol {
    
    var city: CityCoreDataModel? { get set }
    var dailyForecasts: [DailyForecast] { get }
    var currentWeather: [CurrentWeatherModel] { get }
    var hourlyForcast: [HourlyForecastWeatherModel] { get }
    
    var didContentChanged: (() -> Void)?  { get set }
    
    func loadWeather()
    
}




final class MainViewModel: MainViewModelProtocol {

    private lazy var networkService = NetworkService()
    
    var city: CityCoreDataModel? = CityCoreDataModel(cityId: "28580",
                                                     cityName: "Minsk",
                                                     currentTemp: 2,
                                                     weatherDescription: "",
                                                     minTemp: 2,
                                                     maxTemp: 2)

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
    
    func loadWeather() {
        
        if let id = city?.cityId {
            loadCurrentWeather(cityId: id)
            loadDailyForcast(cityId: id)
            loadHourlyForcast(cityId: id)
        } else {
            print("ERROR!", #function)
        }
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
}
