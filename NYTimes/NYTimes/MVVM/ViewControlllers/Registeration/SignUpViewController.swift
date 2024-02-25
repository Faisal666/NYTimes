//
//  SignUpViewController.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/25/24.
//

import UIKit

class SignUpViewController: BaseAuthFormViewController {

    let viewModel: SignUpViewModel

    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(authFormViewModel: self.viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
