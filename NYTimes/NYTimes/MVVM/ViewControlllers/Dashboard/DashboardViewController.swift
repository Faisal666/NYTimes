//
//  DashboardViewController.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import UIKit

class DashboardViewController: UIViewController {

    private var tableView: UITableView!
    private var refreshControl: UIRefreshControl!
    let viewModel: DashboardViewModel
    private var searchController = UISearchController(searchResultsController: nil)

    init(viewModel: DashboardViewModel) {
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
        bindViewModel()
        fetchArticles()
    }

    private func setupUI() {
        self.title = "Dashboard"
        self.view.backgroundColor = .white
        let sortButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortButtonTapped))
        navigationItem.rightBarButtonItem = sortButtonItem
    }

    private func initSubViews() {
        initTableView()
        initRefreshControl()
        initSearchController()
    }

    private func initTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.anchor(top: view.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.bottomAnchor,
                         trailing: view.trailingAnchor)
        registerCells()
    }

    private func registerCells() {
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.className)
    }

    private func initRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }

    private func bindViewModel() {
        viewModel.didFetchArticlesHandler = { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
    }

    private func initSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Articles"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func fetchArticles() {
        viewModel.fetchArticles()
    }

    @objc private func sortButtonTapped() {
        viewModel.sortByDateString()
    }

    @objc private func refreshData(_ sender: Any) {
        fetchArticles()
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.className, for: indexPath) as? ArticleTableViewCell else { return UITableViewCell() }
        let article = viewModel.filteredArticles[indexPath.row]
        cell.setupCell(article: article)
        return cell
    }

}

extension DashboardViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let debouncer = Debouncer(delay: 0.5)
        debouncer.debounce { [weak self] in
            self?.viewModel.filterItems(searchQuery: searchController.searchBar.text)
        }
    }
}
