//
//  RequestProvider.swift
//  Bonami
//
//  Created by Jiří Chlum on 11.11.16.
//  Copyright © 2016 Bonami. All rights reserved.
//

import Foundation

typealias RequestSuccessCompletion = (_ data: Data, _ statusCode: Int) -> Void
typealias RequestFailureCompletion = (_ error: APIError, _ statusCode: Int?) -> Void
typealias RequestClosure = (_ endPoint: EndPoint, _ success: RequestSuccessCompletion, _ failure: RequestFailureCompletion) -> Void

protocol RequestProvider {
    func request(endPoint: EndPoint, success: @escaping RequestSuccessCompletion, failure: @escaping RequestFailureCompletion)
}
