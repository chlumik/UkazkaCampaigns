//
//  MainDataSource.swift
//  Ukazka
//
//  Created by Jiří Chlum on 24/07/2019.
//  Copyright © 2019 Jiří Chlum. All rights reserved.
//

import UIKit

class MainDataSource: NSObject {

    var items: [Campaign] = []

    var didSelect: ((Campaign) -> Void)?

    private func configure(cell: inout AllCampaignsCell, campaign: Campaign) {
        cell.nameText = campaign.name
        cell.descriptionText = campaign.perex
        cell.image = campaign.image
    }

}

extension MainDataSource: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as AllCampaignsCell
        let campaign = items[indexPath.row]
        configure(cell: &cell, campaign: campaign)
        return cell
    }
}

extension MainDataSource: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let campaign = items[indexPath.row]
        didSelect?(campaign)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let campaign = items[indexPath.row]
        var cell = AllCampaignsCell(frame: CGRect(origin: .zero, size: CGSize(width: collectionView.frame.width - 16 * 2, height: 0)))
        configure(cell: &cell, campaign: campaign)
        let size = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize)
        return size
    }
}
