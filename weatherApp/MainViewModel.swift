//
//  MainViewModel.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 15.03.22.
//

protocol MainViewModelProtocol {
    
    var dailyForecasts: [DailyForecast] { get }
    var currentWeather: [CurrentWeatherModel] { get }
    var hourlyForcast: [HourlyForecastWeatherModel] { get }
    
    var didContentChanged: (() -> Void)?  { get set }
    
    func loadCurrentWeather()
    func loadDailyForcast()
    func loadHourlyForcast()
}


final class MainViewModel: MainViewModelProtocol {

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
    
    func loadCurrentWeather() {
        networkService.getCurrentWeather(city: "") { [weak self] currentWeather in
            self?.currentWeather = currentWeather
        }
    }
    
    func loadDailyForcast() {
        networkService.getDailyForcast(city: "") { [weak self] dailyForcastWeather in
            self?.dailyForecasts = dailyForcastWeather.dailyForecasts
        }
    }
    
    func loadHourlyForcast() {
        networkService.getHourlyForcast(city: "") { [weak self] hourlyForcast in
            self?.hourlyForcast = hourlyForcast
        }
    }
    
}
