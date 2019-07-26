//
//  Bonami
//
//  Created by Jiří Chlum on 12/07/16.
//  Copyright © 2016 Bonami. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

    func register<T: UICollectionViewCell>(_: T.Type) {

        //        let Nib = UINib(nibName: T.NibName, bundle: nil)
        //        registerNib(Nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func registerSuplementaryHeader<T: UICollectionReusableView>(_: T.Type) {
        self.register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
    }

	func registerSuplementaryFooter<T: UICollectionReusableView>(_: T.Type) {
		self.register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.reuseIdentifier)
	}

    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
		register(T.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func dequeueReusableSupplementaryViewOfKind<T: UICollectionReusableView>(_ kind: String, forIndexPath indexPath: IndexPath) -> T {
		registerSuplementaryHeader(T.self)
        guard let header = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("could not deque header with identifier: \(T.reuseIdentifier)")
        }
        return header
    }
}

extension UICollectionReusableView: ReusableView { }
