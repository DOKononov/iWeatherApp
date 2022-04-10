//
//  HourlyForecastTableViewCell.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 16.03.22.
//

import UIKit

final class HourlyForecastTableViewCell: UITableViewCell {
    static let rowHeight: CGFloat = 120

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var forcast = [HourlyForecastWeatherModel]() 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func getForcast(forcast: [HourlyForecastWeatherModel]) {
        self.forcast = forcast
        collectionView.reloadData()
    }
    
    func registerCell() {
        let cellNib = UINib(nibName: "\(HourlyForecastCollectionViewCell.self)", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "\(HourlyForecastCollectionViewCell.self)")
    }
     
}

extension HourlyForecastTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forcast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HourlyForecastCollectionViewCell.self)", for: indexPath) as? HourlyForecastCollectionViewCell
        cell?.setupHorForcast(forcast: forcast[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 120)
    }
    
}
