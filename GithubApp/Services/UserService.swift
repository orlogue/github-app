import Foundation

protocol UserServiceProtocol {
    func getUserDetails(for username: String, completed: @escaping (Result<User, NetworkError>) -> Void)
}

final class UserService: UserServiceProtocol {
    static let shared = UserService()
    private let networkManager = NetworkManager.shared
    
    private init() {}
    
    func getUserDetails(for username: String, completed: @escaping (Result<User, NetworkError>) -> Void) {
        return networkManager.getUserDetails(for: username, completed: completed)
    }
}
