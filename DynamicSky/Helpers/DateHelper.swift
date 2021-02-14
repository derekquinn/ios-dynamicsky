import Foundation

class DateHelper {
    static func convertEpochToDay(epoch: Int) -> String {
        let date: Date = NSDate(timeIntervalSince1970: TimeInterval(epoch)) as Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = UIConstantsEN.currentConditionsDateFormat
        let dayOfWeek = dateFormatter.string(from: date)
        return dayOfWeek
    }
    
    static func convertEpochToFullDate(epoch: Int) -> String {
        let date: Date = NSDate(timeIntervalSince1970: TimeInterval(epoch)) as Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d"
        let fullDate = dateFormatter.string(from: date)
        return fullDate
    }
}
