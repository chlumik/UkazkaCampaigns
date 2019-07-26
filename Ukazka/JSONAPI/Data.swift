//
//  Data.swift
//  Bonami
//
//  Created by Jiří Chlum on 11.11.16.
//  Copyright © 2016 Bonami. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Data {
    var toJSON: JSON {
		return JSON.init(self)
    }
}
