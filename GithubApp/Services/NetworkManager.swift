import UIKit

typealias NetworkManagerProtocol = FollowersServiceProtocol & UserServiceProtocol

final class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], NetworkError>) -> Void) {
        let endpoint = "\(baseUrl)/users/\(username)/followers?per_page=99&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.connectionIssue))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == StatusCode.ok else {
                completion(.failure(.badResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
    
    func getUserDetails(for username: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
        let endpoint = baseUrl + "/users/\(username)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.connectionIssue))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == StatusCode.ok else {
                completion(.failure(.badResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let userDetails = try decoder.decode(User.self, from: data)
                completion(.success(userDetails))
            } catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
}
