//
//  MockResponseDataProvider.swift
//  Ukazka
//
//  Created by Jiří Chlum on 24/07/2019.
//  Copyright © 2019 Jiří Chlum. All rights reserved.
//

import Foundation

struct MockResponseDataProvider: RequestResponseDataProvider {

    func jsonData(for endPoint: EndPoint) -> Data? {
        guard let fileName = jsonFileName(for: endPoint) else {
            return nil
        }
        guard let url = Bundle.main.url(forResource: "\(fileName)", withExtension: "json") else {
                return nil
        }
        return try? Data(contentsOf: url)
    }

    private func jsonFileName(for endPoint: EndPoint) -> String? {
        switch endPoint {
        case .campaign(_):
            return "campaign"
        case .campaigns:
            return "campaigns"
        }
    }
}
