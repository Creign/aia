//
//  Utils.swift
//  aia_app_showcase
//
//  Created by Excell on 02/03/2021.
//

import Foundation
import UIKit

class Utils {
    static func setDefault(key: UserDefaultTypes, value: String) {
        DispatchQueue.main.async {
            UserDefaults.standard.set(value, forKey: key.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func getDefault(key: UserDefaultTypes) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue) ?? ""
    }
    
    static func removeAllDefaults() {
        removeUserDefault(.outputSize)
        removeUserDefault(.interval)
    }
    
    static func removeUserDefault(_ key: UserDefaultTypes) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    static func showAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            AppDelegate.shared.getTopLevelViewController()?.present(alert, animated: true, completion: nil)
        }
    }
}
