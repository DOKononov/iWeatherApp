//
//  CitiesVC.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 20.03.22.
//

import UIKit
import CoreData


class CitiesVC: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, NSFetchedResultsControllerDelegate   {

    var searchController = UISearchController(searchResultsController: ResultsVC())
    var viewModel: CitiesViewModelProtocol = CitiesViewModel()
    
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        registerCell()
        setupNavigationItem()
        
        bind()
        viewModel.loadCitiesFromeCoreData()
        viewModel.setupFetchResultController()
        viewModel.fetchResultCotroller.delegate = self

    }

    private func bind() {
        viewModel.didContentChanged = {
            self.collectionView.reloadData()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        viewModel.loadCitiesFromeCoreData()
    }

    private func registerCell() {
        let cellNib = UINib(nibName: "\(CityCollectionViewCell.self)", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "\(CityCollectionViewCell.self)")
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Weather"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        
        let resultsVC = searchController.searchResultsController  as? ResultsVC
        resultsVC?.viewModel.loadCities(city: text)
    }
    


}



extension CitiesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO: -arrayCount
        return viewModel.citiesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CityCollectionViewCell.self)", for: indexPath) as? CityCollectionViewCell
        cell?.setupCell(city: viewModel.citiesArray[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width - 32
        return CGSize(width: width, height: width * 0.3)
    }
    
}
