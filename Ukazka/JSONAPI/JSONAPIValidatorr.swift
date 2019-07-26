import Foundation
import SwiftyJSON

public struct JSONAPIValidator: DocumentValidator {
    public func isValid(json: JSON) -> Bool {
        guard let data = json.dictionary else {
            return false
        }

        let hasData = data["data"] != nil
        let hasError = data["errors"] != nil

        guard hasData || hasError else {
            return false
        }

        guard !hasData && hasError || hasData && !hasError else {
            return false
        }

        return true
    }
}
