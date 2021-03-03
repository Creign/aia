//
//  SecondViewController.swift
//  aia_app_showcase
//
//  Created by Excell on 28/02/2021.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var txtSearch: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ProjectViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initCommon()
        viewModel.timeSeriesDailyAdjusted(symbol: txtSearch.text ?? "")
    }
}

// MARK: - Private Functions
private extension SecondViewController {
    func initCommon() {
        view.backgroundColor = .white
        
        txtSearch.text = "IBM"
        
        setBindings()
        setTable()
    }
    
    func setTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: DailyTableViewCell.identifier,
                                 bundle: nil),
                           forCellReuseIdentifier: DailyTableViewCell.identifier)
        tableView.tableFooterView = UIView()
    }
    
    func setBindings() {
        viewModel.getDailySuccess = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.layoutIfNeeded()
            }
        }
        viewModel.getDailyError = { [weak self] error in
            guard self != nil else { return }
            Utils.showAlert(message: error)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.timeSeriesDailyStock?.timeSeries.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as? DailyTableViewCell {
            let model = viewModel.timeSeriesDailyStock?.timeSeries
            let key = viewModel.timeSeriesDailyKeyValue[indexPath.row]
            cell.bind(key: key, model: (model![key]!))
            return cell
        }
        return UITableViewCell(frame: .zero)
    }
    
    
}
