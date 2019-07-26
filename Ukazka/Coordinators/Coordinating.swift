//
//  Coordinating.swift
//  Bonami
//
//  Created by Jiří Chlum on 27.11.17.
//  Copyright © 2017 Bonami. All rights reserved.
//

import UIKit

protocol Coordinating: class {
	var childCoordinators: [Coordinating] { get set }
	var parent: Coordinating? { get set }
	var coordinatingResponder: UIResponder? { get }
	func start()
}

extension Coordinating {

	/// remove childCoordinator if its exit in childs array
	func remove(childCoordinator coordinator: Coordinator) {
		if childCoordinators.isEmpty {
			return
		}

		for (index, element) in childCoordinators.enumerated() where element === coordinator {
			element.parent = nil
			childCoordinators.remove(at: index)
		}
	}

	/// add new child coordinator to curret coordinator
	func add(childCoordinator coordinator: Coordinator) {
		for element in childCoordinators where element === coordinator {
			return
		}
		childCoordinators.append(coordinator)
		coordinator.parent = self
	}
}
