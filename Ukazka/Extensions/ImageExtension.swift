//
//  ImageExtension.swift
//  Bonami
//
//  Created by Jiří Chlum on 10.08.16.
//  Copyright © 2016 Bonami. All rights reserved.
//

import UIKit
import SDWebImage

struct FetchableImage {
    let url: String

    init?(url: String?) {
        guard let url = url else {
            return nil
        }
        self.url = url
    }
}

extension FetchableImage: Equatable {}

extension FetchableImage {

    func fetchImage(_ imageV: UIImageView, with indicator: UIActivityIndicatorView?, _ completion: ((_ image: UIImage?) -> Void)?) {
        indicator?.startAnimating()
        var toReturnImage: UIImage?
        imageV.sd_setImage(with: URL(string: url)) { image, _, _, _ in

            guard let image = image else {
                toReturnImage = imageV.image
                indicator?.stopAnimating()
                completion?(toReturnImage)
                return
            }
            indicator?.stopAnimating()
            imageV.image = image
            toReturnImage = image
        }
        completion?(toReturnImage)
    }

    func fetchImage(with placeholder: UIImage?, _ completion: ImageFetchCompletion?) {
        if let placeholder = placeholder, let completion = completion {
            completion(placeholder)
        }

        let url = self.url

        SDWebImageManager.shared().downloadImage(with: url.URLValue, options: SDWebImageOptions.highPriority, progress: nil) { image, _, _, _, _ in

            if let completion = completion {
                completion(image)
            }
        }
    }
}

typealias ImageFetchCompletion = (UIImage?) -> Void

enum ImageSize {

    case thumbnail
    case full
}
