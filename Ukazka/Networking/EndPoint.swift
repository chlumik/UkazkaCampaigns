//
//  EndPoint.swift
//  Bonami
//
//  Created by Jiří Chlum on 11.10.16.
//  Copyright © 2016 Bonami. All rights reserved.
//

import Foundation
import Alamofire

enum EndPoint {

	case campaign(campaignNiceURL: String)
    case campaigns

    var path: String {
        switch self {
        case let .campaign(campaignNiceURL):
            return  "campaign/\(campaignNiceURL)"
        case .campaigns:
            return "campaign"
        }
    }

    func headers() -> [String: String] {
        var headers = [String: String]()
        headers["Accept"] = "application/json"
        headers["Accept-Language"] = ""
        if self.method == .post || self.method == .put {
            headers["Content-Type"] = "application/x-www-form-urlencoded"
        } else {
            headers["Content-Type"] = "application/json"
        }
        return headers
    }

    var parameters: [String: Any]? {
        return nil
    }

    var encoding: URLEncoding {
        switch self.method {
        case .get, .put, .delete:
            return .default
        default:
           return .httpBody
        }
    }

    var method: HTTPMethod {
        switch self {
        case .campaign,
             .campaigns:
            return .get
        }
    }
}
