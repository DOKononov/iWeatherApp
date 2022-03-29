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
    
    func loadCurrentWeather(cityId: String)
    func loadDailyForcast(city: String)
    func loadHourlyForcast(city: String)
}




final class MainViewModel: MainViewModelProtocol {
    
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
    
    private lazy var networkService = NetworkService()
    
    func loadCurrentWeather(cityId: String) {
        networkService.getCurrentWeather(city: cityId) { [weak self] currentWeather in
            self?.currentWeather = currentWeather
        }
    }
    
    func loadDailyForcast(city: String) {
        networkService.getDailyForcast(city: city) { [weak self] dailyForcastWeather in
            self?.dailyForecasts = dailyForcastWeather.dailyForecasts
        }
    }
    
    func loadHourlyForcast(city: String) {
        networkService.getHourlyForcast(city: city) { [weak self] hourlyForcast in
            self?.hourlyForcast = hourlyForcast
        }
    }
    
}
