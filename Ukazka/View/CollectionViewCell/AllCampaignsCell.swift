//
//  AllCampaignsCell.swift
//  Bonami
//
//  Created by Jiří Chlum on 12.05.16.
//  Copyright © 2016 Jiří Chlum. All rights reserved.
//

import UIKit
import SnapKit

class AllCampaignsCell: UICollectionViewCell {

    // MARK: - Model
    var nameText: String? {
        didSet {
            campaignNameLabel.text = nameText
        }
    }
    var descriptionText: String? {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    var image: FetchableImage? {
        didSet {
            image?.fetchImage(imageView, with: activityIndicator, nil)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameText = nil
        descriptionText = nil
        image = nil
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

	private var timeBottom: Constraint!
	private var descriptionBottom: Constraint!

    // MARK: - View Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(campaignNameLabel)
        contentView.addSubview(descriptionLabel)
        imageView.addSubview(activityIndicator)

        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
			$0.width.equalTo(frame.width)
            $0.height.equalTo(imageView.snp.width).multipliedBy(0.66)
        }
        campaignNameLabel.snp.makeConstraints {
			$0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }

        descriptionLabel.snp.makeConstraints {
			$0.top.equalTo(campaignNameLabel.snp.bottom).offset(8)
			$0.leading.equalToSuperview().offset(16)
			$0.trailing.equalToSuperview().offset(-16)
			$0.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }

        activityIndicator.snp.makeConstraints {
            $0.center.equalTo(imageView)
        }

        campaignNameLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
        campaignNameLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        descriptionLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        descriptionLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
    }

    // MARK: - setView

    private lazy var campaignNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.numberOfLines = 2
        label.textColor = .gray
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.backgroundColor = UIColor.white
        return imageView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        return indicator
    }()
}
