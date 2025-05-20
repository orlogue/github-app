import Foundation

enum PersistenceError: Error {
    case favoritesRetrievingFailed
    case favoritesSavingFailed
    
    var message: ErrorMessage {
        switch self {
        case .favoritesRetrievingFailed:
            return ErrorMessage(
                title: "Favorites retrieving failed",
                description: "Oops, couldn't load your favorite GitHub accounts :("
            )
        case .favoritesSavingFailed:
            return ErrorMessage(
                title: "Favorites saving failed",
                description: "Oops, couldn't save your favorite GitHub accounts :("
            )
        }
    }
}
