//
//  String+Custom.swift
//  Ukazka
//
//  Created by Jiří Chlum on 24/07/2019.
//  Copyright © 2019 Jiří Chlum. All rights reserved.
//

import Foundation

extension String {

    var URLValue: Foundation.URL {
        return Foundation.URL(string: self) ?? Foundation.URL(string: "https://")!
    }
}
