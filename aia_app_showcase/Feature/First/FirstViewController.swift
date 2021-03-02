//
//  FirstViewController.swift
//  aia_app_showcase
//
//  Created by Excell on 28/02/2021.
//

import UIKit

class FirstViewController: UIViewController {
    
    let viewModel = ProjectViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.timeSeriesIntraday()
        
    }
}
