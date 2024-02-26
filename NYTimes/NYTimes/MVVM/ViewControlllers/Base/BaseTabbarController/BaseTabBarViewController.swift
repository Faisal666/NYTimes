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

                let vc = DashboardViewController(viewModel: DashboardViewModel())
                let navigation = BaseNavigationViewController(rootViewController: vc)
                return navigation

            case .more:
                let vc = UIViewController()
                vc.view.backgroundColor = .red
                return vc
            }
        }

        var title: String {
            switch self {
            case .dashboard:
                "Dashboard"
            case .more:
                "More"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbarItems()
    }

    private func setupTabbarItems() {
        let dashboardViewController = Controllers.dashboard.controller
        dashboardViewController.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(systemName: "square.grid.2x2"), selectedImage: UIImage(systemName: "square.grid.2x2.fill"))

        let moreViewController = Controllers.more.controller
        moreViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: Controllers.more.rawValue)

        viewControllers = [dashboardViewController,
                           moreViewController]
    }
}
