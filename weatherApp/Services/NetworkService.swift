//
//  NetworkService.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 7.03.22.
//

import UIKit
import CoreLocation

final class NetworkService {
    
    private let host = "https://dataservice.accuweather.com/"
    private let tokenPath = "?apikey="
    private let token = "4bd9MqHvj0GA2ILcOXgMyG6dVX2hFgGj"
//    private let token = "Bn4JEWmiKMwpDeLGWnLKPS74d3eRRGui"
    private let pathMetric = "&metric=true"
    
    
    
    //forecasts/v1/daily/5day/28580?apikey=4bd9MqHvj0GA2ILcOXgMyG6dVX2hFgGj&metric=true
    func getDailyForcast(city: String, complition: @escaping (DailyForcastWeatherModel) -> Void) {
        
        let dailyForcastPath = "forecasts/v1/daily/5day/"
        let urlStr = host + dailyForcastPath + city + tokenPath + token + pathMetric
        guard let url = URL(string: urlStr) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
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
    
    
    //currentconditions/v1/28580?apikey=4bd9MqHvj0GA2ILcOXgMyG6dVX2hFgGj
    func getCurrentWeather(city: String, complition: @escaping ([CurrentWeatherModel]) -> Void) {
        
        let currentWeatherPath = "currentconditions/v1/"
        let urlStr = host + currentWeatherPath + city + tokenPath + token
        
        guard let url = URL(string: urlStr) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
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
    

    
    
    
//forecasts/v1/hourly/12hour/28580?apikey=4bd9MqHvj0GA2ILcOXgMyG6dVX2hFgGj&metric=true
    func getHourlyForcast(city: String, complition: @escaping ([HourlyForecastWeatherModel]) -> Void) {
        
        let hourlyForcastPath = "/forecasts/v1/hourly/12hour/"
        let urlStr = host + hourlyForcastPath + city + tokenPath + token + pathMetric
        guard let url = URL(string: urlStr) else { return }
        var reqest = URLRequest(url: url)
        reqest.httpMethod = "GET"
        
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
    
//    locations/v1/cities/autocomplete?apikey=4bd9MqHvj0GA2ILcOXgMyG6dVX2hFgGj&q=Min
    func getLocationAutocomplete(city: String, complition: @escaping ([CityModel]) -> Void) {
        let path = "locations/v1/cities/autocomplete"
        let urlStr = host + path + tokenPath + token + "&q=" + city
        guard let url = URL(string: urlStr) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
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
    
//    locations/v1/cities/geoposition/search?apikey=Bn4JEWmiKMwpDeLGWnLKPS74d3eRRGui&q=37.785834%2C%20-122.406417
    func getWeatherForLocation(lat: String, lon: String, complition: @escaping (CityModel) -> Void) {
        
        let path = "locations/v1/cities/geoposition/"
        let urlStr = host + path + tokenPath + token + "&q=" + lat + "%2C%20" + lon
        guard let url = URL(string: urlStr) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            if let error = error {
                print("ERROR!!!", error.localizedDescription)
            } else if let data = data {
                if let locationWeatherArray = try? JSONDecoder().decode(CityModel.self, from: data) {
                    DispatchQueue.main.async {
                        complition(locationWeatherArray)
                    }
                }
            }
        }.resume()
    }
    
    
}


