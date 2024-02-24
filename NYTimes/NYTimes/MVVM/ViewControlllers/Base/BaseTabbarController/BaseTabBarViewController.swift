//
//  BaseTabBarViewController.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/23/24.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    enum Controllers: Int {
        case dashboard
        case more

        var controller: UIViewController {
            switch self {
            case .dashboard:
                let vc = UIViewController()
                vc.view.backgroundColor = .blue
                return vc

            case .more:
                let vc = UIViewController()
                vc.view.backgroundColor = .red
                return vc
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbarItems()
    }

    private func setupTabbarItems() {
        let dashboardViewController = Controllers.dashboard.controller
        dashboardViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: Controllers.dashboard.rawValue)

        let moreViewController = Controllers.more.controller
        moreViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: Controllers.more.rawValue)

        viewControllers = [dashboardViewController,
                           moreViewController]
    }
}
