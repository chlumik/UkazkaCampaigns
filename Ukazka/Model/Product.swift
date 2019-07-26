//
//  ProductModel.swift
//  Bonami
//
//  Created by Jiří Chlum on 07.05.16.
//  Copyright © 2016 Jiří Chlum. All rights reserved.
//
import SDWebImage
import SwiftyJSON

class Product {
    var type: String?
    var id: String
    var name: String
    var description: String?
    var brandName: String?
    var customerPrice: PriceInfo
    var retailPrice: PriceInfo?
    var shippingPrice: PriceInfo?
    var availability: ProductAvailabilityState
    var properties: [ProductProperty]
    var mainImage: FetchableImage
    var images: [FetchableImage]
    var campaign: String?
    var isFreeShipping: Bool
    var isOverSized: Bool
	var webURL: String
	var isWatchdogEnabled: Bool
	var isLoved: Bool
    var christmasDelivery: Bool?
    var cashback: PriceInfo?
	var ModelUrl: URL?

    init?(resource: ResourceJSONAPI) {
        self.id = resource.id
        self.type = resource.type

        guard let name = resource.attributes["name"] as? String else {
            return nil
        }
        guard let customerPrice = BonamiPriceInfo(object: resource.attributes["customer_price"] as? [String: Any]) else {
            return nil
        }
        guard let properties = Product.parseProperties(from: resource.attributes["properties"] as Any) else {
            return nil
        }
        guard let cartMaxAmount = resource.attributes["cart_max_amount"] as? Int else {
            return nil
        }
        guard let cartAmount = resource.attributes["cart_amount"] as? Int else {
            return nil
        }

        guard let availabilityState = resource.attributes["availability_state"] as? String else {
            return nil
        }

        guard let freeShipping = resource.attributes["free_shipping"] as? Bool else {
            return nil
        }

        guard let isOverSized = resource.attributes["oversized"] as? Bool else {
            return nil
        }

		guard let webURL = resource.attributes["web_url"] as? String else {
			return nil
		}

		guard let watchdog = resource.attributes["watchdog"] as? Bool else {
			return nil
		}

		guard let isLoved = resource.attributes["is_loved"] as? Bool  else {
			return nil
		}

        let mainImageNullable = resource.relationShips.filter {
            $0.key == "main_image"
            }.first?.resources.compactMap {
                FetchableImage(url: $0.attributes["mvp_high_jpeg_url"] as? String)
        }.first

        guard let mainImage = mainImageNullable else {
            return nil
        }

        let images = resource.relationShips.filter {
            $0.key == "images"
            }.first?.resources.compactMap {
                FetchableImage(url: $0.attributes["product_detail_big_jpeg_url"] as? String)
            } ?? []

		self.christmasDelivery = resource.attributes["christmas_delivery"] as? Bool
        self.cashback = BonamiPriceInfo(object: resource.attributes["cashback_price"] as? [String: Any])
		self.isLoved = isLoved
		self.isWatchdogEnabled = watchdog
		self.webURL = webURL
        self.isOverSized = isOverSized
        self.isFreeShipping = freeShipping
        self.availability = BonamiProductAvailabilityState(cartAmount: cartAmount, cartMaxAmount: cartMaxAmount, state: availabilityState)
        self.name = name
        self.customerPrice = customerPrice
        self.properties = properties
        self.mainImage = mainImage
		self.brandName = resource.attributes["brand_name"] as? String
        self.description = resource.attributes["description"] as? String
        self.retailPrice = BonamiPriceInfo(object: resource.attributes["retail_price"] as? [String: Any])
        self.shippingPrice = BonamiPriceInfo(object: resource.attributes["shipping_price"] as? [String: Any])
        self.images = images

		if let url = resource.attributes["3d_model_url_ios"] as? String {
			self.ModelUrl = URL.init(string: url)
		}
    }

    private static func parseImages(from relationShips: [RelationShipsJSONAPI]) -> [FetchableImage] {
        let images: [FetchableImage] = relationShips.flatMap {
            return $0.resources.compactMap {
                guard let string = $0.attributes["mvp_high_jpeg_url"] as? String else {
                    return nil
                }
                return FetchableImage(url: string)
            }
        }

        return images
    }

    fileprivate static func parseProperties(from data: Any) -> [ProductProperty]? {
        guard let arrayOfData = data as? [Any] else {return nil}
        let properties: [ProductProperty]? = arrayOfData.compactMap {
            guard let property = $0 as? [String: Any], let name = property["name"] as? String, let value = property["value"] as? String else {
                return nil
            }
            return BonamiProductProperty(name: name, value: value)
        }
        return properties
    }

}
