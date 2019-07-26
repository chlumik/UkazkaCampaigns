//
//  AvailabilityState.swift
//  Bonami
//
//  Created by Jiří Chlum on 10.11.16.
//  Copyright © 2016 Bonami. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ProductAvailabilityState {
    var state: ProductAvailability {get set}
    var cartAmount: Int {get set}
    var cartMaxAmount: Int {get set}
    var isAvailable: Bool {get}
}

extension ProductAvailabilityState {
    var availableAmount: Int {
        return cartMaxAmount - cartAmount
    }
}

struct BonamiProductAvailabilityState: ProductAvailabilityState {
    var state: ProductAvailability
    var cartAmount: Int
    var cartMaxAmount: Int

    init(cartAmount: Int, cartMaxAmount: Int, state: String) {
        self.cartAmount = cartAmount
        self.cartMaxAmount = cartMaxAmount
        self.state = ProductAvailability(rawValue: state)
    }

    init?(resource: ResourceJSONAPI) {
        guard let cartAmount = resource.attributes["cart_amount"] as? Int,
            let cartMaxAmount = resource.attributes["cart_max_amount"] as? Int,
            let state = resource.attributes["availability_state"] as? String
            else {
                return nil
        }

        self.cartMaxAmount = cartMaxAmount
        self.cartAmount = cartAmount
        self.state = ProductAvailability(rawValue: state)
    }

    var isAvailable: Bool {
        return state.isAvailable() && (cartAmount < cartMaxAmount)
    }

}

enum ProductAvailability: String {
    case sold_out = "SOLD_OUT"
    case unavailable = "UNAVAILABLE"
    case visitor_limit_reached = "VISITOR_LIMIT_REACHED"
    case not_set = "not_set"
    case available_supplier = "AVAILABLE_SUPPLIER"
    case available_stock = "AVAILABLE_STOCK"
    init(rawValue: String) {
        switch rawValue {
        case ProductAvailability.sold_out.rawValue:
            self = .sold_out
        case ProductAvailability.unavailable.rawValue:
            self = .unavailable
        case ProductAvailability.available_stock.rawValue:
            self = .available_stock
        case ProductAvailability.visitor_limit_reached.rawValue:
            self = .visitor_limit_reached
        case ProductAvailability.available_supplier.rawValue:
            self = .available_supplier
        default:
            self = .not_set
        }
    }

    func isAvailable() -> Bool {
        if self == .not_set || self == .available_supplier || self == .available_stock {
            return true
        } else {
            return false
        }
    }
}
