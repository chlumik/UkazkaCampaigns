//
//  UIView+Custom.swift
//  Bonami
//
//  Created by Jiří Chlum on 12/07/16.
//  Copyright © 2016 Bonami. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView {

    static var NibName: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

class LayoutGuideLayer: CAShapeLayer {

	init(guide: UILayoutGuide) {
		super.init()

		self.path = UIBezierPath(rect: guide.layoutFrame).cgPath
		self.lineWidth = 0.5
		self.lineDashPattern = [1, 1, 1, 1]
		self.fillColor = UIColor.clear.cgColor
		self.strokeColor = UIColor.red.cgColor
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
