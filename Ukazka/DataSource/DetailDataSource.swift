//
//  DetailDataSource.swift
//  Ukazka
//
//  Created by Jiří Chlum on 26/07/2019.
//  Copyright © 2019 Jiří Chlum. All rights reserved.
//

import UIKit

class DetailDataSource: NSObject {

    var items: [Product] = []

}

extension DetailDataSource: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as SingleProductCell
        let product = items[indexPath.row]
        cell.configure(with: product)
        return cell
    }
}

extension DetailDataSource: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let product = items[indexPath.row]
        let width = (collectionView.frame.width / 2 - (16 + 16 / 2))
        let cell = SingleProductCell(frame: CGRect(origin: .zero, size: CGSize(width: width, height: 0)))
        cell.configure(with: product)
        let size = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize)
        return size
    }
}
