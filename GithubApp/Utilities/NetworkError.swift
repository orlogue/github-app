import Foundation

enum NetworkError: Error {
    case invalidUrl
    case connectionIssue
    case badResponse
    case invalidData
    
    var message: ErrorMessage {
        switch self {
        case .invalidUrl:
            return ErrorMessage(
                title: "Invalid username",
                description: "We couldn't find the user you're looking for. Please double-check the username"
            )
        case .connectionIssue:
            return ErrorMessage(
                            title: "No Internet Connection",
                            description: "Make sure you're connected to the internet and try again"
                        )
        case .badResponse:
            return ErrorMessage(
                            title: "Server Error",
                            description: "Something went wrong on our end. Please try again later"
                        )
        case .invalidData:
            return ErrorMessage(title: "Incorrect data", description: "Something happened with loaded data. Try again later")
        }
    }
}
