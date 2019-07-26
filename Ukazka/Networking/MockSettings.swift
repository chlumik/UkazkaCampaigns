//
//  MockSettings.swift
//  Ukazka
//
//  Created by Jiří Chlum on 24/07/2019.
//  Copyright © 2019 Jiří Chlum. All rights reserved.
//

import Foundation

struct MockSettings {

    enum DelayType {
        case exact(value: TimeInterval)
        case random(maximum: TimeInterval)
    }

    let delayType: DelayType

    var delay: TimeInterval {
        switch delayType {
        case .exact(let value):
            return value
        case .random(let maximum):
            return TimeInterval.random(in: 0..<maximum)
        }
    }

}
