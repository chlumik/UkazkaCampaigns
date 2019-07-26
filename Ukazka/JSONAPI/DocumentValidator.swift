import Foundation
import SwiftyJSON

public protocol DocumentValidator {
    func isValid(json: JSON) -> Bool
}
