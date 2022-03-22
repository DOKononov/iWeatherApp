//
//  CitiesVC.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 20.03.22.
//

import UIKit


class CitiesVC: UIViewController, UISearchResultsUpdating, UISearchBarDelegate   {

    var searchController = UISearchController(searchResultsController: ResultsVC())
    
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
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        
        let resultsVC = searchController.searchResultsController  as? ResultsVC
        resultsVC?.viewModel.loadCities(city: text)
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


}



extension CitiesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //TODO: -arrayCount
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CityCollectionViewCell.self)", for: indexPath) as? CityCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width - 32
        return CGSize(width: width, height: width * 0.3)
    }
    
}
