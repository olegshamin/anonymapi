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
    
    private let segmentedControl = UISegmentedControl()
    private let tableView = UITableView()
    private let spinner = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Internal properties
    
    weak var delegate: ListViewControllerProtocol?
    
    // MARK: - Private properties
    
    private var controller: ListControllerProtocol!
    private let tableViewHandler = ListTableViewHandler()
    private let segmentedControlHandler = ListSegmentedControlHandler()
    
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
        
        setupTableView()
        setupSegmentedControl()
        controller.reloadData(orderBy: segmentedControlHandler.selectedOrder)
    }

    private func setupTableView() {
        view.add(subview: tableView, withPinEdges: [
            .bottom, .leading, .trailing
        ])

        tableViewHandler.setup(with: tableView, delegate: self)
        spinner.startAnimating()
        spinner.frame = CGRect(
            x: 0,
            y: 0,
            width: tableView.bounds.width,
            height: 44
        )
        tableView.tableFooterView = spinner
    }
    
    private func setupSegmentedControl() {
        view.add(subview: segmentedControl, withPinEdges: [
            .leading, .trailing
        ])
        segmentedControl.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 0
        ).isActive = true
        tableView.topAnchor.constraint(
            equalTo: segmentedControl.bottomAnchor,
            constant: Constants.defaultOffset
        ).isActive = true
        segmentedControlHandler.setup(with: segmentedControl, delegate: self)
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
        controller.reloadData(orderBy: segmentedControlHandler.selectedOrder)
        tableView.tableFooterView?.isHidden = false
    }
    
    func didSelect(post: Post) {
        delegate?.didSelect(post: post)
    }
}

// MARK: - ListSegmentedControlHandlerDelegate

extension ListViewController: ListSegmentedControlHandlerDelegate {
    func didSelect(order: OrderBy) {
        tableViewHandler.clearData()
        controller.reloadData(orderBy: segmentedControlHandler.selectedOrder)
    }
}
