//
//  LogsListViewController.swift
//  Logs
//
//  Created by Juan Dario Delgado L on 1/07/22.
//

import UIKit

class LogsListViewController: UIViewController {
    
    // MARK: - Private properties -
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelectionDuringEditing = false
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 50.0
        tableView.register(
            LogInfoCell.self,
            forCellReuseIdentifier: LogInfoCell.name
        )
        return tableView
    }()
    
    private lazy var errorView: ErrorView = {
        let errorView = ErrorView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        return errorView
    }()
    
    private var errorViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Public properties -
    var presenter: LogsListPresenterInterface!
    
    // MARK: - Lifecycle -
    override func loadView() {
        super.loadView()
        addViews()
        setUpConstraint()
        setUpNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    // MARK: - Private methods -
    private func addViews() {
        view.addSubview(tableView)
        view.addSubview(errorView)
    }
    
    private func setUpConstraint() {
        errorViewHeightConstraint = errorView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            errorViewHeightConstraint,
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = titleTextAttributes
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.backgroundColor = .black
        navigationItem.hidesSearchBarWhenScrolling = false
        title = NSLocalizedString("logsList.title", comment: "")
    }
}

// MARK: - LogsListView interface -
extension LogsListViewController: LogsListViewInterface {
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showError(viewModel: ErrorViewModel) {
        guard errorViewHeightConstraint.constant == 0 else { return }
        errorViewHeightConstraint.constant = 70
        errorView.configure(with: viewModel)
        errorView.setNeedsLayout()
        errorView.layoutIfNeeded()
    }
    
    func hiddenError() {
        guard errorViewHeightConstraint.constant != 0 else { return }
        errorViewHeightConstraint.constant = 0
        errorView.setNeedsLayout()
        errorView.layoutIfNeeded()
    }
}

// MARK: - UITableViewDelegate -
extension LogsListViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - UITableViewDataSource -
extension LogsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LogInfoCell.name, for: indexPath) as! LogInfoCell
        cell.configure(with: presenter.item(at: indexPath))
        return cell
    }
}
