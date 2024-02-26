//
//  BaseAuthFormViewController.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/25/24.
//

import UIKit

class BaseAuthFormViewController: UIViewController {

    var authFormViewModel: BaseAuthFormViewModel
    private var tableView: UITableView!

    init(authFormViewModel: BaseAuthFormViewModel) {
        self.authFormViewModel = authFormViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initSubViews()
        bindViewModel()
    }

    private func initSubViews() {
        initTableView()
    }

    private func initTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.anchor(top: view.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.bottomAnchor,
                         trailing: view.trailingAnchor,
                         padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: -16))
        registerCells()
    }

    private func registerCells() {
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: TextFieldTableViewCell.className)
        tableView.register(DateTextFieldTableViewCell.self, forCellReuseIdentifier: DateTextFieldTableViewCell.className)
        tableView.register(ActionButtonTableViewCell.self, forCellReuseIdentifier: ActionButtonTableViewCell.className)
    }

    private func bindViewModel() {
        authFormViewModel.needToRefreshTableViewHandler = { [weak self] in
            self?.tableView.reloadData()
        }

        authFormViewModel.reloadActionButtonHandler = { [weak self] indexOfActionButton in
            self?.tableView.reloadRows(at: [IndexPath(row: indexOfActionButton, section: 0)], with: .none)
        }
    }

    func moveToHomeScreen() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.changeRootViewController(to: BaseTabBarViewController(), animated: true)
    }

    func displayError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    func actionButtonTapped() { } // Overridden
}

extension BaseAuthFormViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authFormViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch authFormViewModel.cells[indexPath.row] {

        case .actionButton(let title):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ActionButtonTableViewCell.className, for: indexPath) as? ActionButtonTableViewCell else { return UITableViewCell() }
            cell.setupCell(title: title, isEnabled: authFormViewModel.isActionButtonEnabled)
            cell.didTapActionButtonHandler = { [weak self] in
                self?.actionButtonTapped()
            }
            return cell

        case .date:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DateTextFieldTableViewCell.className, for: indexPath) as? DateTextFieldTableViewCell else { return UITableViewCell() }
            let cellType = authFormViewModel.cells[indexPath.row]
            cell.setupCell(with: cellType)
            cell.delegate = self
            return cell

        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.className, for: indexPath) as? TextFieldTableViewCell else { return UITableViewCell() }
            let cellType = authFormViewModel.cells[indexPath.row]
            cell.setupCell(with: cellType)
            cell.delegate = self
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension BaseAuthFormViewController: TextFieldCellDelegate {
    func textFieldCell(_ cell: TextFieldTableViewCell, didChangeText text: String) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let cellType = authFormViewModel.cells[indexPath.row]
        let validationResult = authFormViewModel.validate(input: text, forCellType: cellType)
        switch validationResult {
        case .success:
            cell.configure(with: nil)
        case .failure(let errorMessage):
            cell.configure(with: errorMessage.errorMessage)
        }
        authFormViewModel.fromUpdated(input: text, forCellType: cellType)
    }
    
    func textFieldCell(_ cell: TextFieldTableViewCell, didChangeDate date: Date) {
        authFormViewModel.formBirthdateUpdated(input: date)
    }
}
