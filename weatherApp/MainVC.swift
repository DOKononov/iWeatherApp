//
//  MainVC.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 7.03.22.
//
import UIKit

enum TableViewSections: Int {
    case currentWeather
    case hourlyForcast
    case dailyForcast
}

final class MainVC: UIViewController {
    
    static var tabBarInstance: MainVC {
        let mainVC = MainVC()
        mainVC.tabBarItem.image = UIImage(systemName: "star")
        mainVC.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        return mainVC
    }
    
    private  var viewModel: MainViewModelProtocol = MainViewModel()
    var city: CityCoreDataModel? {
        didSet {
            viewModel.city = city
            viewModel.loadWeather()
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
        viewModel.loadWeather()
        tableViewRegisterCells()
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
        let sections = TableViewSections(rawValue: indexPath.section)
        
        switch sections {
            
        case .currentWeather:
            return setupCurrenWeather(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
        case .hourlyForcast:
            return setupHourlyForcast(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
        case .dailyForcast:
            return setupDailyForcast(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
        case .none:
            return UITableViewCell()
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let sections = TableViewSections(rawValue: section)
        
        switch sections {
        case .currentWeather:
            return nil
        case .hourlyForcast:
            return viewModel.currentWeather.first?.weatherDescription
        case .dailyForcast:
            return "📅 5-DAY FORECAST"
        case .none:
            return nil
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sections = TableViewSections(rawValue: indexPath.section)
        
        switch sections {
        case .currentWeather:
           return CurrentWeatherTableViewCell.rowHeight
        case .hourlyForcast:
            return HourlyForecastTableViewCell.rowHeight
        case .dailyForcast:
            return DailyForcastTableViewCell.rowHeight
        case .none:
            return 50
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
        let currentTemp = viewModel.currentWeather.first?.temperature.metric.value ?? 0
        cell?.setup(dailyForcast: viewModel.dailyForecasts[indexPath.row], currentTemp: currentTemp )
        return cell
    }
    
    private func setupHourlyForcast(tableView: UITableView, indexPath: IndexPath) -> HourlyForecastTableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(HourlyForecastTableViewCell.self)", for: indexPath) as? HourlyForecastTableViewCell
        cell?.getForcast(forcast: viewModel.hourlyForcast)
        return cell
    }
    
    
    
}
