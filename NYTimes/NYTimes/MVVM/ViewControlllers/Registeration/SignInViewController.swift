//
//  SignInViewController.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/25/24.
//

import UIKit

class SignInViewController: BaseAuthFormViewController {

    let viewModel: SignInViewModel

    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(authFormViewModel: self.viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func actionButtonTapped() {
        viewModel.signIn { [weak self] result in
            switch result {
            case .success:
                self?.moveToHomeScreen()
            case .failure(let error):
                self?.displayError(message: error.errorMessage)
            }
        }
    }
}
