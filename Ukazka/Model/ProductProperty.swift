//
//  ProductProperty.swift
//  Bonami
//
//  Created by Jiří Chlum on 10.11.16.
//  Copyright © 2016 Bonami. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ProductProperty {
    var name: String {get set}
    var value: String {get set}
}

struct BonamiProductProperty: ProductProperty {
    var name: String
    var value: String

    init(name: String, value: String) {
        self.name = name
        self.value = value
    }

    init?(json: JSON) {
        guard let name = json["name"].string, let value = json["value"].string else {
            return nil
        }
        self.name = name
        self.value = value
    }

    init?(data: (String, String)?) {
        guard let data = data else {
            return nil
        }
        self.name = data.0
        self.value = data.1
    }

}
