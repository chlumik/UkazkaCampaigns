//
//  AppDelegate.swift
//  Bonami
//
//  Created by Jiří Chlum on 12/07/16.
//  Copyright © 2016 Bonami. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public enum APIError: Error {
    case noConnection
    case parseError
    case responseError
    case success
    case tokenStoreError
    case authorizedError
    case serverError
    case empty
    case notSet
    case notExist
	case notAvailableResource

    var description: String {
        return self.localizedDescription()
    }

    private func localizedDescription() -> String {
        let toReturn = ""
        return toReturn
    }
}
