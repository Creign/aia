//
//  MainViewController.swift
//  aia_app_showcase
//
//  Created by Excell on 28/02/2021.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initCommon()
    }
}

// MARK: - Private Functions
private extension MainViewController {
    func initCommon() {
        self.setViewControllers()
//        Utils.removeAllDefaults()
    }
    
    func setViewControllers() {
        let firstViewController = FirstViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "First", image: nil, tag: 0)
        
        let secondViewController = SecondViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "Second", image: nil, tag: 1)
        
        let thirdViewController = ThirdViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: "Third", image: nil, tag: 2)
        
        viewControllers = [firstViewController, secondViewController, thirdViewController]
    }
}
