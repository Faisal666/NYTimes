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
    let userSessionManager: UserSessionManaging

    init(userSessionManager: UserSessionManaging = UserSessionManager()) {
        self.userSessionManager = userSessionManager
    }

    func getInitialViewController() -> UIViewController {
        let isLoggedIn = userSessionManager.currentUser != nil
        
        if isLoggedIn {
            let tabbarController = BaseTabBarViewController()
            let navigation = BaseNavigationViewController(rootViewController: tabbarController)
            return navigation

        } else {
            let userAuthViewController = UserAuthViewController(viewModel: AuthenticationViewModel())
            let navigation = BaseNavigationViewController(rootViewController: userAuthViewController)
            return navigation
        }
    }
}
