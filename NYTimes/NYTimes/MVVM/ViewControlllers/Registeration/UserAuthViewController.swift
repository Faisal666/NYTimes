//
//  UserAuthViewController.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/25/24.
//

import UIKit

class UserAuthViewController: UIViewController {

    private var signInViewController: SignInViewController!
    private var signUpViewController: SignUpViewController!
    private var segmentedControl: UISegmentedControl!
    private var contentContainerView: UIView!
    private var didAddInitialChildView: Bool = false
    var viewModel: AuthenticationViewModel

    init(viewModel: AuthenticationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initSegmentedControl()
        initContentContainerVuew()
        initChildViewControllers()
        bindViewModel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !didAddInitialChildView {
            didAddInitialChildView = true
            add(asChildViewController: signInViewController)
        }
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "NY Times"
    }

    private func initSegmentedControl() {
        segmentedControl = UISegmentedControl(items: ["Login", "Register"])
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        view.addSubview(segmentedControl)
        segmentedControl.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                leading: view.leadingAnchor,
                                padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0))
    }

    private func initContentContainerVuew() {
        contentContainerView = UIView()
        view.addSubview(contentContainerView)
        contentContainerView.anchor(top: segmentedControl.bottomAnchor,
                                    leading: view.leadingAnchor,
                                    bottom: view.bottomAnchor,
                                    trailing: view.trailingAnchor,
                                    padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
    }

    private func initChildViewControllers() {
        signInViewController = SignInViewController(viewModel: SignInViewModel())
        signUpViewController = SignUpViewController(viewModel: SignUpViewModel())
    }

    private func bindViewModel() {
        viewModel.onAuthStateChanged = { [weak self] state in
            switch state {
                case .signIn:
                    self?.switchToChildViewController(self?.signInViewController)
                case .signUp:
                    self?.switchToChildViewController(self?.signUpViewController)
            }
        }
    }

    @objc private func selectionDidChange(_ sender: UISegmentedControl) {
        viewModel.toggleState()
    }

    private func switchToChildViewController(_ childViewController: UIViewController?) {
        guard let childVC = childViewController else { return }

        let currentVC = childVC is SignInViewController ? signUpViewController : signInViewController
        currentVC?.willMove(toParent:nil)
        currentVC?.view.removeFromSuperview()
        currentVC?.removeFromParent()

        add(asChildViewController: childVC)
    }

    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        contentContainerView.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
}
