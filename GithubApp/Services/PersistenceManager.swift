import Foundation

protocol FavoriteServiceProtocol {
    static func updateWith(favorite: FavoriteUser, actionType: PersistenceActionType?, completion: @escaping (PersistenceError?) -> Void)
    static func isUserAlreadyFavorite(_ user: FavoriteUser) -> Bool
    static func retrieveFavorites(completion: @escaping (Result<[FavoriteUser], PersistenceError>) -> Void)
    static func saveFavorites(favorites: [FavoriteUser]) -> PersistenceError?
}

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager: FavoriteServiceProtocol {
    enum Keys {
        static let favorites = "favorites"
    }
    
    static private let defaults = UserDefaults.standard
    
    static func updateWith(favorite: FavoriteUser, actionType: PersistenceActionType?, completion: @escaping (PersistenceError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favoriteUsers):
                
                let isUserAlreadyFavorite = favoriteUsers.contains(favorite)
                
                switch actionType {
                case .add:
                    favoriteUsers.append(favorite)
                case .remove:
                    favoriteUsers.removeAll { $0.username == favorite.username }
                case .none:
                    if isUserAlreadyFavorite {
                        favoriteUsers.removeAll { $0.username == favorite.username }
                    } else {
                        favoriteUsers.append(favorite)
                    }
                }
                
                completion(saveFavorites(favorites: favoriteUsers))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func isUserAlreadyFavorite(_ user: FavoriteUser) -> Bool {
        guard let favoritesData = defaults.data(forKey: Keys.favorites),
              let favorites = try? JSONDecoder().decode([FavoriteUser].self, from: favoritesData) else {
            return false
        }
        
        return favorites.contains(user)
        
    }
    
    static func retrieveFavorites(completion: @escaping (Result<[FavoriteUser], PersistenceError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([FavoriteUser].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.favoritesRetrievingFailed))
        }
    }
    
    static func saveFavorites(favorites: [FavoriteUser]) -> PersistenceError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .favoritesSavingFailed
        }
    }
}
