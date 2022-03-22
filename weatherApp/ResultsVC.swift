//
//  ResultsControllerVC.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 21.03.22.
//

import UIKit

class ResultsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var viewModel: ResultsViewModelProtocol = ResultsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        registerCell()
    }
    
    private func bind() {
        viewModel.didContentChanged = {
            self.tableView.reloadData()
        }
    }
    
    private func registerCell() {
        let cellNib = UINib(nibName: "\(ResultTableViewCell.self)", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "\(ResultTableViewCell.self)")
    }

    
}
 


extension ResultsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ResultTableViewCell.self)", for: indexPath) as? ResultTableViewCell
        cell?.setupCell(city: viewModel.cities[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
