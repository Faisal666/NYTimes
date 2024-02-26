//
//  MoreViewController.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import Foundation
import UIKit

class MoreViewViewModel {

    let userSessionManager: UserSessionManaging
    let sections: [SectionType] = [.profileHeader, .details, .settings]
    let detailsCells: [DetailsType] = DetailsType.allCases

    init(userSessionManager: UserSessionManaging = UserSessionManager()) {
        self.userSessionManager = userSessionManager
    }

    lazy var currnetUser: User? = {
        return userSessionManager.currentUser
    }()

    enum SectionType: Int, CaseIterable {
        case profileHeader
        case details
        case settings

        var numberOfCells: Int {
            switch self {
            case .profileHeader:
                1
            case .details:
                DetailsType.allCases.count
            case .settings:
                1
            }
        }

        var headerTitle: String {
            switch self {
            case .details:
                return "Details"
            case .settings:
                return "Settings"
            default:
                return String()
            }
        }
    }

    enum DetailsType: Int, CaseIterable {
        case nationlID
        case phone
        case birthdate

        var title: String {
            switch self {
            case .nationlID:
                return "National ID"
            case .phone:
                return "Phone number"
            case .birthdate:
                return "Birth of date"
            }
        }

    }

    func getUserBirthdate() -> String? {
        let date = currnetUser?.birthdate
        guard let date else { return nil }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }

    func logout() {
        userSessionManager.logOutUser()
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        let userAuthViewController = UserAuthViewController(viewModel: AuthenticationViewModel())
        let navigation = BaseNavigationViewController(rootViewController: userAuthViewController)
        sceneDelegate.changeRootViewController(to: navigation, animated: true)
    }
}
