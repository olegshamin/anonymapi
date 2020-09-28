//
//  ListViewController.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 25.09.2020.
//

import UIKit

protocol ListViewControllerProtocol: class {
    func didSelect(post: Post)
}

final class ListViewController: UIViewController {
    
    // MARK: - Views
    
    private let tableView = UITableView()
    private let spinner = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Internal properties
    
    weak var delegate: ListViewControllerProtocol?
    
    // MARK: - Private properties
    
    private var controller: ListControllerProtocol!
    private let tableViewHandler = ListTableViewHandler()
    
    // MARK: - Initialization
    
    static func create(
        controller: ListControllerProtocol,
        delegate: ListViewControllerProtocol?
    ) -> ListViewController {

        let viewController = ListViewController()
        
        viewController.controller = controller
        viewController.delegate = delegate
        controller.view = viewController

        return viewController
    }
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.add(subview: tableView)
        
        setupTableView()
        controller.reloadData()
    }

    private func setupTableView() {
        tableViewHandler.setup(with: tableView, delegate: self)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        tableView.tableFooterView = spinner
    }
}

// MARK: - ListViewProtocol

extension ListViewController: ListViewProtocol {
    
    func handleDataReloadSuccess(models: [Post]) {
        tableViewHandler.reload(with: models)
        tableView.tableFooterView?.isHidden = true
    }
    
    func handle(error: Error) {
        display(error: error)
    }
}

// MARK: - ListTableViewHandlerDelegate

extension ListViewController: ListTableViewHandlerDelegate {
    
    func lastCellDidVisible() {
        controller.reloadData()
        tableView.tableFooterView?.isHidden = false
    }
    
    func didSelect(post: Post) {
        delegate?.didSelect(post: post)
    }
}
