//
//  PriceInfo.swift
//  Bonami
//
//  Created by Jiří Chlum on 10.11.16.
//  Copyright © 2016 Bonami. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol PriceInfo: StringRepresentable {
    var amount: Float {get set}
    var currency: String {get}
}

extension PriceInfo {
    var stringRepresentable: String {
        return CurrencyHelper.formatCurrency(with: self)
    }
}

struct BonamiPriceInfo: PriceInfo {
    var amount: Float
    let currency: String

    init?(json: JSON) {
        guard let amountString = json["amount"].string,
            let currency = json["currency"].string,
            let amount = Float(amountString)
        else {
            return nil
        }
        self.amount = amount
        self.currency = currency
    }

    init(amount: Float, currency: String) {
        self.amount = amount
        self.currency = currency
    }

    init?(object: [String: Any]?) {
        guard let amount = object?["amount"] as? String, let currency = object?["currency"] as? String, let floatAmount = Float(amount) else {
            return nil
        }
        self.amount = floatAmount
        self.currency = currency
    }
}

extension BonamiPriceInfo: Equatable {}
