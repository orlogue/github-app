import Foundation

extension Date {
    func convertToFormattedString(_ format: DateFormat) -> String {
        return formatted(format.style)
    }
}
