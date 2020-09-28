//
//  ListSegmentedControlHandler.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 28.09.2020.
//

import UIKit

protocol ListSegmentedControlHandlerDelegate: class {
    func didSelect(order: OrderBy)
}

final class ListSegmentedControlHandler {
    
    // MARK: - Internal properties
    
    weak var delegate: ListSegmentedControlHandlerDelegate?
    private(set) var selectedOrder: OrderBy = .createdAt
    
    // MARK: - Private properties
    
    private weak var segmentedControl: UISegmentedControl?
    private let orders: [OrderBy] = [.createdAt, .mostPopular, .mostCommented]
    
    // MARK: - Setup

    func setup(
        with segmentedControl: UISegmentedControl,
        delegate: ListSegmentedControlHandlerDelegate?
    ) {
        self.segmentedControl = segmentedControl
        self.delegate = delegate

        orders.map { $0.title }.enumerated().forEach {
            segmentedControl.insertSegment(withTitle: $0.element, at: $0.offset, animated: false)
        }

        segmentedControl.addTarget(self, action: #selector(didSelectSegment(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = orders.firstIndex(of: selectedOrder) ?? 0
    }
    
    // MARK: - Actions
    
    @objc private func didSelectSegment(_ sender: UISegmentedControl) {
        selectedOrder = orders[sender.selectedSegmentIndex]
        delegate?.didSelect(order: selectedOrder)
    }
    
}
