//
//  RequestDataProvider.swift
//  Ukazka
//
//  Created by Jiří Chlum on 24/07/2019.
//  Copyright © 2019 Jiří Chlum. All rights reserved.
//

import Foundation

protocol RequestResponseDataProvider {
    func jsonData(for endPoint: EndPoint) -> Data?
}
