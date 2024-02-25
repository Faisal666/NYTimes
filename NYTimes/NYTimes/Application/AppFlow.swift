//
//  AppFlow.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/25/24.
//

import UIKit

protocol AppFlow {
    func getInitialViewController() -> UIViewController
}

final class AppFlowReal: AppFlow {
    func getInitialViewController() -> UIViewController {
        let isLoggedIn = false
        if isLoggedIn {
            let mainVC = UIViewController()
            mainVC.view.backgroundColor = .green
            return mainVC
        } else {
            let userAuthViewController = UserAuthViewController(viewModel: AuthenticationViewModel())
            let navigation = BaseNavigationViewController(rootViewController: userAuthViewController)
            return navigation
        }
    }
}
