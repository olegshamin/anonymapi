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
    private var posts: [Post] = []
    
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
    
    func reload(with posts: [Post]) {

        self.posts.append(contentsOf: posts)
        let indexPaths = calculateIndexPathsToReload(from: posts)
        tableView?.beginUpdates()
        tableView?.insertRows(at: indexPaths, with: .none)
        tableView?.endUpdates()
    }
    
    func clearData() {
        posts.removeAll()
        tableView?.reloadData()
    }
    
    // MARK: - Private helpers
    
    private func calculateIndexPathsToReload(from posts: [Post]) -> [IndexPath] {
        let startIndex = self.posts.count - posts.count
        let endIndex = startIndex + posts.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}

// MARK: - UITableViewDataSource

extension ListTableViewHandler: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: PostTableViewCell = tableView.dequeue(for: indexPath)
        let config = PostTableViewCell.Config(post: posts[indexPath.row])
        cell.configure(with: config)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListTableViewHandler: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(post: posts[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= posts.count - 1{
            delegate?.lastCellDidVisible()
        }
    }
}
