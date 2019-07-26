//
//  CampaignsRepository.swift
//  Ukazka
//
//  Created by Jiří Chlum on 24/07/2019.
//  Copyright © 2019 Jiří Chlum. All rights reserved.
//

import Foundation

protocol CampaignsLoader {
    func loadCampaigns(_ completion: @escaping ((BonamiResult<[Campaign]>) -> Void))
}

protocol CampaignLoader {
    func loadCampaign(withId id: String,_ completion: @escaping ((BonamiResult<[Product]>) -> Void))
}

typealias CampaignsRepositoable = CampaignsLoader & CampaignLoader

class CampaignsRepository: CampaignsRepositoable {

    let service: CampaignServicing

    init(service: CampaignServicing) {
        self.service = service
    }

    func loadCampaigns(_ completion: @escaping ((BonamiResult<[Campaign]>) -> Void)) {
        service.loadCampaigns(completion)
    }

    func loadCampaign(withId id: String,_ completion: @escaping ((BonamiResult<[Product]>) -> Void)) {
        service.loadCampaign(withId: id, completion)
    }
}
