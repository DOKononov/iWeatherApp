//
//  MainVC.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 7.03.22.
//
import UIKit

class MainVC: UIViewController {
    
    var viewModel: MainViewModelProtocol = MainViewModel()
    var city: CityCoreDataModel? {
        didSet {
            viewModel.city = city
            loadWeather()
        }
    }
    
    @IBOutlet private weak var currentCity: UILabel!
    @IBOutlet private weak var currentTemperature: UILabel!
    @IBOutlet private weak var currentWeatherDescription: UILabel!
    @IBOutlet private weak var currentMinToMax: UILabel!
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        loadWeather()
        tableViewRegisterCells()
    }
    

    private func loadWeather() {
        
        
        if let cityId = viewModel.city?.cityId {
            viewModel.loadCurrentWeather(cityId: cityId)
            viewModel.loadDailyForcast(city: cityId)
            viewModel.loadHourlyForcast(city: cityId)
        } else {
            print ("ERROR! ", #function)
        }
        

    }
    
    private func bind() {
        viewModel.didContentChanged = {
            self.tableView.reloadData()
        }
    }
    
    
    private func tableViewRegisterCells() {

        let forcastTableViewCell = UINib(nibName: "\(DailyForcastTableViewCell.self)", bundle: nil)
        tableView.register(forcastTableViewCell, forCellReuseIdentifier: "\(DailyForcastTableViewCell.self)")
        
        let currentWeatherTableViewCellNib = UINib(nibName: "\(CurrentWeatherTableViewCell.self)", bundle: nil)
        tableView.register(currentWeatherTableViewCellNib, forCellReuseIdentifier: "\(CurrentWeatherTableViewCell.self)")
        
        let hourlyWeatherTableViewCellNib = UINib(nibName: "\(HourlyForecastTableViewCell.self)", bundle: nil)
        tableView.register(hourlyWeatherTableViewCellNib, forCellReuseIdentifier: "\(HourlyForecastTableViewCell.self)")
    }
    
    
}






extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return viewModel.dailyForecasts.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return setupCurrenWeather(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
        }
        if indexPath.section == 1 {
            return setupHourlyForcast(tableView: tableView, indexPath: indexPath)!
        }
        if indexPath.section == 2 {
            return setupDailyForcast(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
        }
        return UITableViewCell()
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return "📅 5-DAY FORECAST"
        }
        if section == 1 {
            return viewModel.currentWeather.first?.weatherDescription
        }
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        } else if indexPath.section == 1 {
            return 120.0
        } else if indexPath.section == 2 {
            return 50
        } else {
            return 50.0
        }
    }
    
    

    //MARK: -funcs setup tableView
    
    private func setupCurrenWeather(tableView: UITableView, indexPath: IndexPath) -> CurrentWeatherTableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CurrentWeatherTableViewCell.self)", for: indexPath) as? CurrentWeatherTableViewCell
       
        cell?.setupCellWith(currentWeather: viewModel.currentWeather.first, dailyForcast: viewModel.dailyForecasts, currentCity: viewModel.city)
        return cell
    }
    
    private func setupDailyForcast(tableView: UITableView, indexPath: IndexPath) ->  DailyForcastTableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(DailyForcastTableViewCell.self)", for: indexPath) as? DailyForcastTableViewCell
        cell?.currentTemp = viewModel.currentWeather.first?.temperature.metric.value ?? 0
        cell?.setup(dailyForcast: viewModel.dailyForecasts[indexPath.row])
        return cell
    }
    
    private func setupHourlyForcast(tableView: UITableView, indexPath: IndexPath) -> HourlyForecastTableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(HourlyForecastTableViewCell.self)", for: indexPath) as? HourlyForecastTableViewCell
        cell?.getForcast(forcast: viewModel.hourlyForcast)
        return cell
    }
    

    
}
