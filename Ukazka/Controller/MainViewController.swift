//
//  MainViewController.swift
//  Ukazka
//
//  Created by Jiří Chlum on 23/07/2019.
//  Copyright © 2019 Jiří Chlum. All rights reserved.
//

import UIKit
import SnapKit

protocol MainViewControllerDelegate: class {
    func didSelect(campaign: Campaign)
}

class MainViewController: UIViewController, ErrorHandlingController {

    lazy var datasource: MainDataSource = {
        let dataSource = MainDataSource()
        dataSource.didSelect = { [weak self] campaign in
            self?.delegate?.didSelect(campaign: campaign)
        }
        return dataSource
    }()

    private let campaignsLoader: CampaignsLoader

    weak var delegate: MainViewControllerDelegate?

    // MARK: - Vc LifeCycle

    init(campaignsLoader: CampaignsLoader) {
        self.campaignsLoader = campaignsLoader
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

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self.datasource
        collectionView.dataSource = self.datasource
        collectionView.alwaysBounceVertical = true
        collectionView.scrollsToTop = true
        collectionView.isScrollEnabled = true
        collectionView.isPrefetchingEnabled = false
        return collectionView
    }()

    // MARK: - Methods

    private func loadCampaigns() {
        campaignsLoader.loadCampaigns { [weak self] (result) in
            switch result {
            case .success(let campaigns):
                self?.datasource.items = campaigns
                self?.collectionView.reloadData()
            case .failure(let error):
                self?.handle(error: error)
            }
        }
    }
}
