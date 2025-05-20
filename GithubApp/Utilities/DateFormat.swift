import Foundation

enum DateFormat: String {
    case monthYear = "MMMM yyyy"
    case date = "dd.MM.yyyy"
    case dateTime =  "yyyy-MM-dd'T'HH:mm:ssZ"
    
    var style: Date.FormatStyle {
        switch self {
        case .monthYear:
            return .dateTime.month(.wide).year()
        case .date:
            return .dateTime.day().month().day().locale(.current)
        case .dateTime:
            return .dateTime.day().month().year().hour().minute()
        }
    }
}
