import Foundation
import SwiftyJSON

enum DeserializerError: Error {
    case invalideStructure
    case resourceTypeMissing
    case resourceIdMissing
    case resourceTypeUnregistred
}

protocol JSONAPIInitializable {
    init?(resource: ResourceJSONAPI)
}

protocol JSONAPIError {
    var status: String? {get set}
    var title: String? {get set}
    var detail: String? {get set}
    var source: JSON? {get set}
}

class BonamiJSONAPIError: JSONAPIError {
    var status: String?
    var title: String?
    var detail: String?
    var source: JSON?

    init?(object: JSON) {
        let status = object["status"].stringValue
        let title = object["title"].stringValue
        let detail = object["detail"].stringValue

        self.status = status
        self.title = title
        self.detail = detail
        self.source = object["source"]

    }
}

protocol JSONAPILinks {
    var this: String? {get set}
    var first: String? {get set}
    var prev: String? {get set}
    var next: String? {get set}
    var last: String? {get set}
}

private struct Links: JSONAPILinks {
    fileprivate var this: String?
    fileprivate var first: String?
    fileprivate var prev: String?
    fileprivate var next: String?
    fileprivate var last: String?
}

struct JSONAPIObject {
    let data: [ResourceJSONAPI]
    let error: [JSONAPIError]?
    let links: JSONAPILinks?
}

struct ResourceType: Equatable, Hashable {
	let id: String
	let type: String

	static func == (lhs: ResourceType, rhs: ResourceType) -> Bool {
		return lhs.type == rhs.type && lhs.id == rhs.id
	}
}

public class DeserializatorJSONAPI {
    private var data: JSON!
    private var extractedData: [ResourceJSONAPI] = []
    private let validator: DocumentValidator = JSONAPIValidator()
    private var links: Links?
    private var errors: [JSONAPIError]?
	var included: [ResourceType: ResourceJSONAPI] = [:]

    private var deserialized: JSONAPIObject {
        return JSONAPIObject(data: extractedData, error: errors, links: links)
    }

    public init() {}

    func process(with data: JSON) -> JSONAPIObject {
        self.data = data
        process()
        return deserialized
    }

    func process(with data: Data) -> JSONAPIObject {
        self.data = data.toJSON
        process()
        return deserialized
    }

    private func process() {
        if !validator.isValid(json: data) {
            return
        }
        if let data = data["data"].array {
            for representation in data {
                if let resource = handleSingleRepresenation(data: representation) {
                    self.extractedData.append(resource)
                }
            }
        } else {
            let data = self.data["data"]
            if let resource = handleSingleRepresenation(data: data) {
                self.extractedData.append(resource)
            }
        }

        if let included = data["included"].array {
            for represenation in included {
                if let resource = handleSingleRepresenation(data: represenation) {
						let type = ResourceType(id: resource.id, type: resource.type)
						self.included[type] = resource
                    }
                }
            }

        self.extractedData.forEach {
            $0.resolveIncluded()
        }
        resolveLinks()
        resolveErrors()
    }

    private func resolveErrors() {
        guard let errors = data["errors"].array else {
            return
        }
        self.errors = errors.compactMap {
            BonamiJSONAPIError(object: $0)
        }
    }

    private func resolveLinks() {
        let links = data["links"]
        let this: String? = links["this"].string
        let first: String? = links["first"].string
        let prev: String? = links["prev"].string
        let next: String? = links["next"].string
        let last: String? = links["last"].string
        self.links = Links(this: this, first: first, prev: prev, next: next, last: last)
    }

    private func handleSingleRepresenation(data: JSON) -> ResourceJSONAPI? {
        guard let resource = ResourceJSONAPI(data: data, parent: self) else {return nil}
        return resource
    }

    private func extractAttribute(key: String, from data: JSON) -> Any? {
        let value = data["attributes"][key]
        if let _ = value.null {
            return nil
        } else {
            return value.rawValue
        }
    }
}
