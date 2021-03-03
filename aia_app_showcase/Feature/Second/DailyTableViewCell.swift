//
//  DailyTableViewCell.swift
//  aia_app_showcase
//
//  Created by Excell on 03/03/2021.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var openDesc: UILabel!
    @IBOutlet weak var highDesc: UILabel!
    @IBOutlet weak var lowDesc: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
}

// MARK: - Functions
extension DailyTableViewCell {
    func bind(key: String, model: TimeSeriesDaily) {
        self.keyLabel.text = key
        self.openDesc.text = model.open
        self.highDesc.text = model.high
        self.lowDesc.text = model.low
    }
}
