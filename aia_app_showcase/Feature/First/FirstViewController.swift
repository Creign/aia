//
//  FirstViewController.swift
//  aia_app_showcase
//
//  Created by Excell on 28/02/2021.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var txtSearch: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ProjectViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCommon()
        viewModel.timeSeriesIntraday(symbol: txtSearch.text ?? "")
    }
}

// MARK: - Private Functions
private extension FirstViewController {
    func initCommon() {
        txtSearch.text = "IBM"
        txtSearch.delegate = self
        
        setBindings()
        setTable()
    }
    
    func setTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: IntradateTableViewCell.identifier,
                                 bundle: nil),
                           forCellReuseIdentifier: IntradateTableViewCell.identifier)
        tableView.tableFooterView = UIView()
    }
    
    func setBindings() {
        viewModel.getIntradaySuccess = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.layoutIfNeeded()
            }
        }
        viewModel.getIntradayError = { [weak self] error in
            guard self != nil else { return }
            Utils.showAlert(message: error)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.timeSeriesIntradayStock?.timeSeries.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: IntradateTableViewCell.identifier, for: indexPath) as? IntradateTableViewCell {
            let model = viewModel.timeSeriesIntradayStock?.timeSeries
            let key = viewModel.timeSeriesKeyValue[indexPath.row]
            cell.bind(key: key, model: (model![key]!))
            return cell
        }
        return UITableViewCell(frame: .zero)
    }
    
    
}

// MARK: - UISearchBarDelegate
extension FirstViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.timeSeriesIntraday(symbol: txtSearch.text ?? "")
    }
}
