//
//  ThirdViewController.swift
//  aia_app_showcase
//
//  Created by Excell on 28/02/2021.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var outputSizeSegment: UISegmentedControl!
    @IBOutlet weak var intervalSegment: UISegmentedControl!
    
    @IBAction func didTap(_ sender: UIButton) {
        print(Utils.getDefault(key: .interval))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initCommon()
    }
}

// MARK: - Private Functions
private extension ThirdViewController {
    func initCommon() {
        view.backgroundColor = .white
        
        outputSizeSegment.addTarget(self,
                                    action: #selector(didTapOutputSizeSegment(_:)),
                                    for: .valueChanged)
        
        intervalSegment.addTarget(self,
                                  action: #selector(didTapIntervalSegment(_:)), for: .valueChanged)
        
    }
}

// MARK: - Actions
private extension ThirdViewController {
    @objc func didTapOutputSizeSegment(_ sender: UISegmentedControl) {
        let ind = outputSizeSegment.selectedSegmentIndex
        let value = outputSizeSegment.titleForSegment(at: ind) ?? ""
        
        Utils.setDefault(key: .outputSize, value: value.lowercased())
    }
    
    @objc func didTapIntervalSegment(_ sender: UISegmentedControl) {
        let ind = intervalSegment.selectedSegmentIndex
        let value = intervalSegment.titleForSegment(at: ind) ?? ""
        
        Utils.setDefault(key: .interval, value: value.lowercased())
    }
}
