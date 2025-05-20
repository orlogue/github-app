import UIKit

protocol FollowersServiceProtocol {
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], NetworkError>) -> Void)
}

final class FollowersService: FollowersServiceProtocol {
    static let shared = FollowersService()
    
    private let networkManager: NetworkManagerProtocol = NetworkManager.shared
    private var isLoading = false
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], NetworkError>) -> Void) {

        guard !isLoading else { return }
        isLoading = true
        
        networkManager.getFollowers(for: username, page: page) { [weak self] result in
            self?.isLoading = false
            completion(result)
        }
    }
}
