//
//  BonamiResult.swift
//  Bonami
//
//  Created by Jiří Chlum on 11.11.16.
//  Copyright © 2016 Bonami. All rights reserved.
//

import Foundation

public enum BonamiResult<T> {
    case success(T)
    case failure(APIError)
}
