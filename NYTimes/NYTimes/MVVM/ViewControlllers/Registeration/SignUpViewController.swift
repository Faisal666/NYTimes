//
//  SignUpViewController.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/25/24.
//

import UIKit

class SignUpViewController: BaseAuthFormViewController {

    init(viewModel: SignUpViewModel) {
        super.init(authFormViewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
//
//    override func dateFieldUpdated(cellType: AuthFormCellTypes, input: Date) {
//        
//    }
//
//    override func textFieldUpdated(cellType: AuthFormCellTypes, input: String) {
//        
//    }
}
