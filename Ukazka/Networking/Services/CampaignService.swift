//
//  CampaignService.swift
//  Ukazka
//
//  Created by Jiří Chlum on 24/07/2019.
//  Copyright © 2019 Jiří Chlum. All rights reserved.
//

import Foundation

protocol CampaignServicing {
    func loadCampaigns(_ completion: @escaping ((BonamiResult<[Campaign]>) -> Void))
    func loadCampaign(withId id: String, _ completion: @escaping ((BonamiResult<[Product]>) -> Void))
}

class CampaignsService: CampaignServicing {
    let provider: RequestProvider

    init(provider: RequestProvider) {
        self.provider = provider
    }

    func loadCampaigns(_ completion: @escaping ((BonamiResult<[Campaign]>) -> Void)) {
        let endPoint = EndPoint.campaigns
        provider.request(endPoint: endPoint, success: { (data, statusCode) in
            switch statusCode {
            case 200:
                let jsonObject = DeserializatorJSONAPI().process(with: data)
                let campaigns = jsonObject.data.compactMap {
                    Campaign(resource: $0)
                }
                if campaigns.isEmpty {
                    completion(.failure(.empty))
                    return
                }
                completion(.success(campaigns))
            default:
                completion(.failure(.responseError))
            }
        }) { (error, _) in
            completion(.failure(error))
        }
    }

    func loadCampaign(withId id: String, _ completion: @escaping ((BonamiResult<[Product]>) -> Void)) {
        let endPoint = EndPoint.campaign(campaignNiceURL: id)
        provider.request(endPoint: endPoint, success: { (data, statusCode) in
            switch statusCode {
            case 200:
                let jsonObject = DeserializatorJSONAPI().process(with: data)
                let products = jsonObject.data.compactMap {
                    Product(resource: $0)
                }
                if products.isEmpty {
                    completion(.failure(.empty))
                    return
                }
                completion(.success(products))
            default:
                completion(.failure(.responseError))
            }
        }) { (error, _) in
            completion(.failure(error))
        }
    }
}
