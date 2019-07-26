//
//  IndicatorView.swift
//  Bonami
//
//  Created by Jiří Chlum on 11.08.16.
//  Copyright © 2016 Bonami. All rights reserved.
//

import UIKit
import SnapKit

class IndicatorView: UIActivityIndicatorView {
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: CGRect.zero)
        self.style = .gray
    }
}
