import Foundation

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.dateTime.rawValue
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDateDisplayFormat(_ format: DateFormat = .dateTime) -> String {
        guard let date = self.convertToDate() else { return "" }
        return date.convertToFormattedString(format)
    }
}
