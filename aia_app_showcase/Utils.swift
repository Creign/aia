//
//  Utils.swift
//  aia_app_showcase
//
//  Created by Excell on 02/03/2021.
//

import Foundation

class Utils {
    static func setDefault(key: UserDefaultTypes, value: String) {
        DispatchQueue.main.async {
            UserDefaults.standard.set(value, forKey: key.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func getDefault(key: UserDefaultTypes) -> String {
        return UserDefaults.standard.string(forKey: key.rawValue) ?? ""
    }
    
    static func removeAllDefaults() {
        removeUserDefault(.outputSize)
        removeUserDefault(.interval)
    }
    
    static func removeUserDefault(_ key: UserDefaultTypes) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
