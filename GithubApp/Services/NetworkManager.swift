import UIKit

protocol NetworkManagerProtocol {
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], NetworkError>) -> Void)

    func getUserDetails(for username: String, completed: @escaping (Result<User, NetworkError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], NetworkError>) -> Void) {
        let endpoint = "\(baseUrl)/users/\(username)/followers?per_page=99&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.connectionIssue))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == StatusCode.ok else {
                completed(.failure(.badResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }.resume()
    }
    
    func getUserDetails(for username: String, completed: @escaping (Result<User, NetworkError>) -> Void) {
        let endpoint = baseUrl + "/users/\(username)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.connectionIssue))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == StatusCode.ok else {
                completed(.failure(.badResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let userDetails = try decoder.decode(User.self, from: data)
                completed(.success(userDetails))
            } catch {
                completed(.failure(.invalidData))
            }
        }.resume()
    }
}
