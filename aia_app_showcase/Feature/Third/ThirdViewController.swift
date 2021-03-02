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
    @IBOutlet weak var pickerView: UIPickerView!
    
    let viewModel = ProjectViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initCommon()
    }
}

// MARK: - Private Functions
private extension ThirdViewController {
    func initCommon() {
        view.backgroundColor = .white
        
        outputSizeSegment.selectedSegmentIndex = viewModel.getOutputSegmentLoadIndex()
        outputSizeSegment.addTarget(self,
                                    action: #selector(didTapOutputSizeSegment(_:)),
                                    for: .valueChanged)
        
        intervalSegment.selectedSegmentIndex = viewModel.getIntervalSegmentLoadIndex()
        intervalSegment.addTarget(self,
                                  action: #selector(didTapIntervalSegment(_:)), for: .valueChanged)
        
        pickerView.delegate = self
        pickerView.selectRow(viewModel.getApiKeyIndex(),
                             inComponent: 0,
                             animated: true)
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension ThirdViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.apiKeys.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.apiKeys[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Utils.setDefault(key: .apiKey, value: viewModel.apiKeys[row])
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
