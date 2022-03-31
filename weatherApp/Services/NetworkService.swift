//
//  NetworkService.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 7.03.22.
//

import Foundation
import UIKit

final class NetworkService {
    
    private let networkQueue = DispatchQueue(label: "networkQueue", qos: .userInitiated)
    private let host = "https://dataservice.accuweather.com/"
    private let tokenPath = "?apikey="
    private let token = "4bd9MqHvj0GA2ILcOXgMyG6dVX2hFgGj"
    private let pathMetric = "&metric=true"
    
    
    
    //https://dataservice.accuweather.com/forecasts/v1/daily/5day/28580?apikey=4bd9MqHvj0GA2ILcOXgMyG6dVX2hFgGj&metric=true
    func getDailyForcast(city: String, complition: @escaping (DailyForcastWeatherModel) -> Void) {
        
        let dailyForcastPath = "forecasts/v1/daily/5day/"
        let urlStr = host + dailyForcastPath + city + tokenPath + token + pathMetric
        guard let url = URL(string: urlStr) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        networkQueue.async {
            URLSession.shared.dataTask(with: request) { data, responce, error in
                if let error = error {
                    print("ERROR!!!", error.localizedDescription)
                } else if let data = data {
                    if let dailyForcast = try? JSONDecoder().decode(DailyForcastWeatherModel.self, from: data) {
                        DispatchQueue.main.async {
                            complition(dailyForcast)
                        }
                        
                    }
                }
            }.resume()
        }
    }
    
    
    //https://dataservice.accuweather.com/currentconditions/v1/28580?apikey=4bd9MqHvj0GA2ILcOXgMyG6dVX2hFgGj
    func getCurrentWeather(city: String, complition: @escaping ([CurrentWeatherModel]) -> Void) {
        
        let currentWeatherPath = "currentconditions/v1/"
        let urlStr = host + currentWeatherPath + city + tokenPath + token
        
        guard let url = URL(string: urlStr) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        networkQueue.async {
            URLSession.shared.dataTask(with: request) { data, responce, error in
                if let error = error {
                    print("ERROR!!!", error.localizedDescription)
                } else if let data = data {
                    if let currentWeather = try? JSONDecoder().decode([CurrentWeatherModel].self, from: data) {
                        DispatchQueue.main.async {
                            complition(currentWeather)
                        }
                    }
                }
            }.resume()
        }
    }
    
    //https://apidev.accuweather.com/developers/Media/Default/WeatherIcons/41-s.png
    func downloadImage(imageID: Int, complition: @escaping (UIImage) -> Void) {
        
        let host = "https://apidev.accuweather.com/developers/Media/Default/WeatherIcons/"
        var id: String {
            return imageID < 10 ? "0" + String(imageID) : String(imageID)
        }
        
        guard let url = URL(string: host + String(format: "%@-s.png", id)) else {return}
        
        networkQueue.async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        complition(image)
                    }
                }
            }
        }
    }
    
    
    
//https://dataservice.accuweather.com//forecasts/v1/hourly/12hour/28580?apikey=4bd9MqHvj0GA2ILcOXgMyG6dVX2hFgGj&metric=true
    func getHourlyForcast(city: String, complition: @escaping ([HourlyForecastWeatherModel]) -> Void) {
        
        let hourlyForcastPath = "/forecasts/v1/hourly/12hour/"
        let urlStr = host + hourlyForcastPath + city + tokenPath + token + pathMetric
        guard let url = URL(string: urlStr) else { return }
        var reqest = URLRequest(url: url)
        reqest.httpMethod = "GET"
        
        networkQueue.async {
            URLSession.shared.dataTask(with: reqest) { data, responce, error in
                if let error = error {
                    print("Error: loadHourlyForcast()", error.localizedDescription)
                } else if let data = data {
                    if let hourlyForcast = try?
                        JSONDecoder().decode([HourlyForecastWeatherModel].self, from: data) {
                        DispatchQueue.main.async {
                            complition(hourlyForcast)
                        }
                    }
                }
            }.resume()
        }
    }
    
//    locations/v1/cities/autocomplete?apikey=4bd9MqHvj0GA2ILcOXgMyG6dVX2hFgGj&q=Min
    
    func getLocationAutocomplete(city: String, complition: @escaping ([CityModel]) -> Void) {
        let path = "locations/v1/cities/autocomplete"
        let urlStr = host + path + tokenPath + token + "&q=" + city
        guard let url = URL(string: urlStr) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        networkQueue.async {
            URLSession.shared.dataTask(with: request) { data, responce, error in
                if let error = error {
                    print("ERROR!!!", error.localizedDescription)
                } else if let data = data {
                    if let cities = try? JSONDecoder().decode([CityModel].self, from: data) {
                        DispatchQueue.main.async {
                            complition(cities)
                        }
                    }
                }
            }.resume()
        }
    }
}


