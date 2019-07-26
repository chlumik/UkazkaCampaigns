//
//  DetailViewController.swift
//  Ukazka
//
//  Created by Jiří Chlum on 26/07/2019.
//  Copyright © 2019 Jiří Chlum. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, ErrorHandlingController {

    lazy var datasource: DetailDataSource = {
        let dataSource = DetailDataSource()
        return dataSource
    }()

    let campaignLoader: CampaignLoader

    private let campaignId: String

    // MARK: - Vc LifeCycle

    init(campaignId: String, campaignLoader: CampaignLoader) {
        self.campaignLoader = campaignLoader
        self.campaignId = campaignId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadCampaigns()
    }

    override func loadView() {
        super.loadView()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Views

    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self.datasource
        collectionView.dataSource = self.datasource
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = .zero
        collectionView.scrollIndicatorInsets = .zero
        collectionView.isPrefetchingEnabled = false
        return collectionView
    }()

    // MARK: - Methods

    private func loadCampaigns() {
        campaignLoader.loadCampaign(withId: campaignId ) { [weak self] (result) in
            switch result {
            case .success(let products):
                self?.datasource.items = products
                self?.collectionView.reloadData()
            case .failure(let error):
                self?.handle(error: error)
            }
        }
    }
}
