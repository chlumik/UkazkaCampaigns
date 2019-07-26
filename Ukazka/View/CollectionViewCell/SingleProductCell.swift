//
//  SingleProductCell.swift
//  Bonami
//
//  Created by Jiří Chlum on 14.05.16.
//  Copyright © 2016 Jiří Chlum. All rights reserved.
//

import SnapKit

class SingleProductCell: UICollectionViewCell {

    func configure(with product: Product) {
        nameLabel.text = product.name
        priceLabel.text = product.customerPrice.stringRepresentable
        product.mainImage.fetchImage(productPhotoView, with: indicator, nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    var isSeparatorHidden: Bool = false {
        didSet {
            separator.isHidden = isSeparatorHidden
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
		productPhotoView.alpha = 1
		nameLabel.text = nil
		priceLabel.text = nil
    }

    // MARK: - View Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        contentView.addSubview(productPhotoView)
        productPhotoView.addSubview(indicator)
        contentView.addSubview(nameLabel)
		contentView.addSubview(priceLabel)
        contentView.addSubview(separator)

		contentView.addLayoutGuide(bottomLayoutGuide)

		productPhotoView.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview()
			$0.top.equalTo(contentView.snp.top)
			$0.width.equalTo(frame.width)
			$0.height.equalTo(frame.width)
		}

		indicator.snp.makeConstraints {
			$0.center.equalToSuperview()
		}

        separator.isHidden = isSeparatorHidden

		bottomLayoutGuide.snp.makeConstraints {
			$0.top.equalTo(productPhotoView.snp.bottom).offset(4)
			$0.leading.trailing.equalToSuperview()
			$0.bottom.equalTo(contentView.snp.bottom)
		}

		nameLabel.snp.makeConstraints {
			$0.leading.trailing.equalTo(bottomLayoutGuide)
			$0.top.equalTo(bottomLayoutGuide.snp.top)
			$0.height.greaterThanOrEqualTo(16)
		}

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(5).priority(100)
			$0.leading.trailing.equalTo(bottomLayoutGuide)
			$0.height.greaterThanOrEqualTo(16)
        }

		separator.snp.makeConstraints {
			$0.top.equalTo(priceLabel.snp.bottom).offset(4)
			$0.bottom.equalTo(bottomLayoutGuide.snp.bottom)
			$0.height.equalTo(1)
			$0.leading.trailing.equalTo(bottomLayoutGuide)
		}

		nameLabel.setContentHuggingPriority(UILayoutPriority.init(1000), for: .vertical)
    }

    // MARK: - setView

	let bottomLayoutGuide: UILayoutGuide = UILayoutGuide()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 3
		label.textColor = UIColor.gray
        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        label.textColor = UIColor.black
        return label
    }()

    let productPhotoView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()

    let indicator = IndicatorView()

	let separator: UIView = {
		let separator = UIView()
		separator.backgroundColor = UIColor.gray
		return separator
	}()
}
