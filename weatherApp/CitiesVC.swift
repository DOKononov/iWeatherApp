//
//  CitiesVC.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 20.03.22.
//

import UIKit
import CoreData

final class CitiesVC: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, NSFetchedResultsControllerDelegate   {
    
    static var tabBarInstance: CitiesVC {
        let citiesVC = CitiesVC()
        citiesVC.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        citiesVC.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        return citiesVC
    }
    
    
    private var searchController = UISearchController(searchResultsController: ResultsVC())
     var viewModel: CitiesViewModelProtocol = CitiesViewModel()
    
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        
        registerCell()
        setupNavigationItem()
        
        bind()
        viewModel.loadCitiesFromeCoreData()
        viewModel.updateCitiesData()
    }
    
    private func bind() {
        viewModel.didContentChanged = {
            self.tableView.reloadData()
        }
    }
    
    private func registerCell() {
        let cellNib = UINib(nibName: "\(CityTableViewCell.self)", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "\(CityTableViewCell.self)")
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Weather"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty, text != "" else {return}
        
        let resultsVC = searchController.searchResultsController  as? ResultsVC
        resultsVC?.viewModel.loadCities(city: text)
    }
    
}

//MARK: tableView
extension CitiesVC:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.citiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CityTableViewCell.self)", for: indexPath) as? CityTableViewCell
        let city = viewModel.citiesArray[indexPath.row]
        cell?.setupCell(city: city)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = UIScreen.main.bounds.width - 32
        return width * 0.3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let coreDataModel = viewModel.citiesArray[indexPath.row]
        guard let cityToPresent =  cityModelFrom(coreDataModel: coreDataModel) else {return}
        
        guard let mainVC = tabBarController?.viewControllers?.first as? MainVC else {return}
        mainVC.viewModel.city = CityModel(cityId: cityToPresent.cityId,
                                          cityName: cityToPresent.cityName,
                                          country: nil)
        
        self.tabBarController?.selectedIndex = 0
    }
    
    private func cityModelFrom(coreDataModel: CityEntity) -> CityCoreDataModel? {
        if  let id = coreDataModel.cityId,
            let name = coreDataModel.cityName  {
            let cityModel = CityCoreDataModel(cityId: id,
                                              cityName: name,
                                              currentTemp: coreDataModel.currentTemp,
                                              weatherDescription: description,
                                              minTemp: coreDataModel.minTemp,
                                              maxTemp: coreDataModel.maxTemp)
            return cityModel
        } else {
            print ("ERROR! ", #function)
            return nil
        }
    }
    
    //MARK: delete city from coredata
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard !viewModel.citiesArray[indexPath.row].myLocation else {return nil}
        
        let deleteCell = UIContextualAction(style: .destructive, title: "Delete") { action, view, _ in
            let selectedCity = self.viewModel.citiesArray[indexPath.row]
            CoreDataService.shared.managedObjectContext.delete(selectedCity)
            CoreDataService.shared.saveContext()
            self.viewModel.loadCitiesFromeCoreData()
            self.tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteCell])
    }
       
}
