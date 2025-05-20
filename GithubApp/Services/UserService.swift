import Foundation

protocol UserServiceProtocol {
    func getUserDetails(for username: String, completion: @escaping (Result<User, NetworkError>) -> Void)
}

final class UserService: UserServiceProtocol {
    static let shared = UserService()
    private let networkManager = NetworkManager.shared
    
    private init() {}
    
    func getUserDetails(for username: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
        return networkManager.getUserDetails(for: username, completion: completion)
    }
}
