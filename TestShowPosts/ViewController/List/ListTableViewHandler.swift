//
//  ListTableViewHandler.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 27.09.2020.
//

import UIKit

protocol ListTableViewHandlerDelegate: class {
    func lastCellDidVisible()
    func didSelect(post: Post)
}

final class ListTableViewHandler: NSObject {
    
    // MARK: - Public properties

    weak var delegate: ListTableViewHandlerDelegate?
    
    // MARK: - Private properties

    private weak var tableView: UITableView?
    
    private var postsByCreated: [Post] = []
    private var postsByMostPopular: [Post] = []
    private var postsByMostCommented: [Post] = []
    private var orderBy = OrderBy.createdAt

    // MARK: - Setup

    func setup(with tableView: UITableView, delegate: ListTableViewHandlerDelegate?) {

        self.tableView = tableView
        self.delegate = delegate

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none

        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(PostTableViewCell.self)
    }
    
    func reload(with posts: [Post], orderBy: OrderBy) {

        self.orderBy = orderBy
        
        switch orderBy {
        case .createdAt:
            postsByCreated.append(contentsOf: posts)
        case .mostPopular:
            postsByMostPopular.append(contentsOf: posts)
        case .mostCommented:
            postsByMostCommented.append(contentsOf: posts)
        }
        
        let indexPaths = calculateIndexPathsToReload(from: posts)
        tableView?.beginUpdates()
        tableView?.insertRows(at: indexPaths, with: .none)
        tableView?.endUpdates()
    }
    
    func reloadData(orderBy: OrderBy) {
        self.orderBy = orderBy
        tableView?.reloadData()
    }
    
    func postsCount(orderBy: OrderBy) -> Int {
        switch orderBy {
        case .createdAt:
            return postsByCreated.count
        case .mostPopular:
            return postsByMostPopular.count
        case .mostCommented:
            return postsByMostCommented.count
        }
    }
    
    // MARK: - Private helpers
    
    private func calculateIndexPathsToReload(from posts: [Post]) -> [IndexPath] {
        let startIndex = getPosts().count - posts.count
        let endIndex = startIndex + posts.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    private func getPosts() -> [Post] {
        switch orderBy {
        case .createdAt:
            return postsByCreated
        case .mostPopular:
            return postsByMostPopular
        case .mostCommented:
            return postsByMostCommented
        }
    }
}

// MARK: - UITableViewDataSource

extension ListTableViewHandler: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getPosts().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: PostTableViewCell = tableView.dequeue(for: indexPath)
        let config = PostTableViewCell.Config(post: getPosts()[indexPath.row])
        cell.configure(with: config)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListTableViewHandler: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(post: getPosts()[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= getPosts().count - 1{
            delegate?.lastCellDidVisible()
        }
    }
}
