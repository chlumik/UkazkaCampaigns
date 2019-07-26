//
//  Campaign.swift
//  Ukazka
//
//  Created by Jiří Chlum on 23/07/2019.
//  Copyright © 2019 Jiří Chlum. All rights reserved.
//

import Foundation

struct Campaign {
    let type: String
    let id: String
    let name: String
    let authorTitle: String?
    let perex: String?
    let description: String?
    let authorDescription: String?
    let image: FetchableImage?
    let types: [String]

    private let resourceType: String = "campaign"

    init?(resource: ResourceJSONAPI) {
        guard resource.type == resourceType else {
            return nil
        }
        self.id = resource.id
        self.type = resource.type

        guard let name = resource.attributes["name"] as? String else {
            return nil
        }

        self.types = (resource.attributes["types"] as? [String]) ?? []
        let perex = resource.attributes["perex"] as? String
        let description = resource.attributes["description"] as? String
        self.name = name
        self.authorTitle = resource.attributes["author_title"] as? String
        self.perex = perex
        self.description = description
        self.image = FetchableImage(url: resource.attributes["image_main_mvp_jpeg_high_url"] as? String)
        self.authorDescription = resource.attributes["author_description"] as? String
    }
}

extension Campaign: Equatable {}
