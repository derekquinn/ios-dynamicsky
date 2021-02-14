import Foundation

class DateHelper {
    static func convertEpochToDay(epoch: Int) -> String {
        let date: Date = NSDate(timeIntervalSince1970: TimeInterval(epoch)) as Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        let dayOfWeek = dateFormatter.string(from: date)
        return dayOfWeek
    }
}
