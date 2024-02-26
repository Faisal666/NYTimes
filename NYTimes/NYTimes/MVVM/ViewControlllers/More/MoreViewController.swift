//
//  MoreViewController.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import UIKit

class MoreViewController: UIViewController {

    private var tableView: UITableView!
    let viewModel: MoreViewViewModel
    private var searchController = UISearchController(searchResultsController: nil)

    init(viewModel: MoreViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initSubViews()
    }

    private func setupUI() {
        self.title = "More"
        self.view.backgroundColor = .white
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
        tableView.anchor(top: view.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.bottomAnchor,
                         trailing: view.trailingAnchor)
        registerCells()
    }

    private func registerCells() {
        tableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: HeaderTableViewCell.className)
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.className)
        tableView.register(LogoutTableViewCell.self, forCellReuseIdentifier: LogoutTableViewCell.className)
    }
}

extension MoreViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.sections[indexPath.section] {
        case .profileHeader:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.className, for: indexPath) as? HeaderTableViewCell else { return UITableViewCell() }
            cell.setupCell(name: viewModel.currnetUser?.name, email: viewModel.currnetUser?.email)
            return cell

        case .details:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.className, for: indexPath) as? DetailsTableViewCell else { return UITableViewCell() }
            let cellType = viewModel.detailsCells[indexPath.row]
            switch cellType {
            case .nationlID:
                cell.setupCell(title: cellType.title, subtitle: viewModel.currnetUser?.nationalID ?? "")
            case .phone:
                cell.setupCell(title: cellType.title, subtitle: viewModel.currnetUser?.phoneNumber ?? "")
            case .birthdate:
                cell.setupCell(title: cellType.title, subtitle: viewModel.getUserBirthdate() ?? "")
            }
            return cell
        case .settings:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LogoutTableViewCell.className, for: indexPath) as? LogoutTableViewCell else { return UITableViewCell() }
            cell.didTapLogoutHandler = { [weak self] in
                self?.viewModel.logout()
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch viewModel.sections[section]  {
        case .details, .settings:
            let header = CustomHeaderView()
            header.setupView(title: viewModel.sections[section].headerTitle)
            return header
        default:
            return nil
        }
    }
}
