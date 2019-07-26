//
//  CurrencyHelper.swift
//  Bonami
//
//  Created by Jiří Chlum on 13/07/16.
//  Copyright © 2016 Bonami. All rights reserved.
//

import Foundation

struct CurrencyHelper {

    static func formatCurrency(with priceInfo: PriceInfo) -> String {
        return formatCurrency(float: priceInfo.amount, currency: priceInfo.currency)
    }

    static func formatCurrency(string amount: String?, currency: String?) -> String? {
        guard let am = amount, let curr = currency else {
            return nil
        }
        return self.formatCurrency(string: am, currency: curr)
    }

    static func formatCurrency(float amount: Float, currency: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        switch currency {
        case "CZK":
            formatter.locale = Locale(identifier: "cs_CZ")
            formatter.maximumFractionDigits = 0
        case "EUR":
            formatter.locale = Locale(identifier: "sk_SK")
            formatter.maximumFractionDigits = 2
        case "PLN":
            formatter.locale = Locale(identifier: "pl_PL")
            formatter.maximumFractionDigits = 0
        case "RON":
            formatter.locale = Locale(identifier: "ro_RO")
            formatter.currencySymbol = "Lei"
            formatter.maximumFractionDigits = 0
		case "HUF":
			formatter.locale = Locale(identifier: "hu")
			formatter.currencySymbol = "Ft"
			formatter.maximumFractionDigits = 0
        default:
            NSLog("[CurrencyHelper] Unknown currency \(currency), returning unformatted string")
            return ("\(amount) \(currency)")
        }
        return formatter.string(from: NSNumber(value: amount as Float))!
    }
}
