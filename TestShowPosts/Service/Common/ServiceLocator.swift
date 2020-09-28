//
//  ServiceLocator.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import Foundation

final class ServiceLocator {

    // MARK: - Properties

    static let shared = ServiceLocator()

    private lazy var registeredServices = [String: Any]()

    func register<T>(_ serviceType: T.Type, block: @escaping () -> T) {

        let key = self.typeName(of: serviceType)

        self.registeredServices[key] = block
    }

    func get<T>() -> T {
        let key = self.typeName(of: T.self)

        if let service = registeredServices[key] as? T {
            return service
        } else if let serviceReceiveClosure = registeredServices[key] as? (() -> T) {
            return serviceReceiveClosure()
        } else {
            fatalError("Unknown service \(key)")
        }
    }

    // MARK: - Helper

    private func typeName(of some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
}
