import Foundation
import SwiftyJSON

public class ResourceJSONAPI {
    public var id: String
    public var type: String
    public var attributes: [String: Any] = [:]
    public var relationShips: [RelationShipsJSONAPI] = []
    weak var parent: DeserializatorJSONAPI?

    public convenience init?(data: JSON, parent: DeserializatorJSONAPI?) {
        guard let data = data.dictionaryObject else {
            return nil
        }
        self.init(data: data, parent: parent)
    }

    public init?(data: [String: Any], parent: DeserializatorJSONAPI?) {
        guard let id = data["id"] as? String, let type = data["type"] as? String else {
            return nil
        }
        self.id = id
        self.type = type
        self.parent = parent
        if let attributes = data["attributes"] as? [String: Any] {
            self.attributes = attributes
        }

        if let relationShips = data["relationships"] as? [String: Any] {
            for (key, relData) in relationShips {
                if let relationShip = RelationShipsJSONAPI(key: key, data: relData as! [String: Any]) {
                    self.relationShips.append(relationShip)
                }
            }
        }
    }

    public func resolveIncluded() {
        if let included = parent?.included, !self.relationShips.isEmpty {
            for relationShip in self.relationShips {
                for resource in relationShip.resources {
					let type = ResourceType(id: resource.id, type: resource.type)
					if let value = included[type] {
						resource.attributes = value.attributes
						resource.relationShips = value.relationShips
						if !resource.relationShips.isEmpty {
							resource.parent = self.parent
							resource.resolveIncluded()
						}
					}
                }
            }
        }
    }
}

public class RelationShipsJSONAPI {
    public var key: String
    public var resources: [ResourceJSONAPI] = []
    public var links: [String: Any]?

    init?(key: String, data: [String: Any]) {
        self.key = key
       self.links = data["links"] as? [String: Any]

        for one in normalizeJSONAPIObjectToArray(data["data"]) {
            if let resource = ResourceJSONAPI(data: one, parent: nil) {
                resources.append(resource)
            }
        }
    }

}

func normalizeJSONAPIObjectToArray(_ object: Any?) -> [[String: Any]] {
    if object is NSArray {
        return object as? [[String: Any]] ?? []
    } else if let object = object as? NSDictionary {
        let array = [object]
        return array as? [[String: Any]] ?? []
    }
    return []
}
