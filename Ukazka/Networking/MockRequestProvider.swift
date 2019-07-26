//
//  MockRequestProvider.swift
//  Ukazka
//
//  Created by Jiří Chlum on 24/07/2019.
//  Copyright © 2019 Jiří Chlum. All rights reserved.
//

import Foundation

class MockRequestProvider: RequestProvider {

    var settings: MockSettings
    var responseDataProvider: RequestResponseDataProvider

    init(settings: MockSettings, dataProvider: RequestResponseDataProvider) {
        self.settings = settings
        self.responseDataProvider = dataProvider
    }

    func request(endPoint: EndPoint, success: @escaping RequestSuccessCompletion, failure: @escaping RequestFailureCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + self.settings.delay) { [weak self] in
            if let data = self?.responseDataProvider.jsonData(for: endPoint) {
                success(data, 200)
            } else {
                failure(.serverError, 500)
            }
        }
    }
    
}
