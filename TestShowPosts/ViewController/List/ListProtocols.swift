//
//  ListProtocols.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import Foundation

protocol ListViewProtocol: class {
//    func handleLoginFinished(with result: LoginResult)
    func handleDataReloadSuccess(models: [Post])
    func handle(error: Error)
}

protocol ListControllerProtocol: class {
    var view: ListViewProtocol? { get set }
    func reloadData()
}
