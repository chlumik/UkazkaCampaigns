//
//  Coordinator.swift
//  Bonami
//
//  Created by Jiří Chlum on 25.10.17.
//  Copyright © 2017 Bonami. All rights reserved.
//

import UIKit

/// allow wrap coordinatorResponder method and add into array queue
typealias CoordinatingQueuedMessage = () -> Void

public class Coordinator: UIResponder, Coordinating {
	var childCoordinators: [Coordinating] = []
	weak var parent: Coordinating?

	func start() {}

    var coordinatingResponder: UIResponder? {
		return parent as? UIResponder
	}

	///	List of wrapped methods requiring dependency which is not available right now
	fileprivate(set) var queuedMessages: [CoordinatingQueuedMessage] = []

	///	Simply add the message wrapped in the closure. Mind the capture list for `self`.
	func enqueueMessage(_ message: @escaping CoordinatingQueuedMessage ) {
		queuedMessages.append( message )
	}

	///	Call this each time your Coordinator's dependencies are updated
	public func processQueuedMessages() {
		//	make a local copy
		let arr = queuedMessages
		//	clean up the queue, in case it's re-populated while this pass is ongoing
		queuedMessages.removeAll()
		//	execute each message
		arr.forEach { $0() }
	}
}
