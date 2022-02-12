import Foundation

public class ValidationHelper {

    static func isZipCodeValid(zipCode: String) -> Bool {
        let isZipValid: Bool = NSPredicate(format: "SELF MATCHES %@", "^\\d{5}(?:[-\\s]?\\d{4})?$")
            .evaluate(with: zipCode.uppercased())
        return isZipValid

    }
}
