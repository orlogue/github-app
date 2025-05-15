import Foundation

final class FollowersModel {
    private let followersService: FollowersServiceProtocol = FollowersService.shared
    
    private(set) var followers: [Follower] = []
    private(set) var filteredFollowers: [Follower] = []
    private(set) var page: Int = 1
    private(set) var hasMoreFollowers = true
    private(set) var isSearching = false
    
    var isEmpty: Bool {
        return followers.isEmpty
    }
    
    var currentFollowersList: [Follower] {
        return isSearching ? filteredFollowers : followers
    }
    
    func loadFollowers(for username: String, onStart: @escaping () -> Void, completion: @escaping (Result<[Follower], NetworkError>) -> Void) {
        onStart()
        
        followersService.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let newFollowers):
                self.processFollowersData(newFollowers)
                completion(.success(self.followers))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadMoreFollowers(for username: String, onStart: (() -> Void)?, completion: @escaping (Result<[Follower], NetworkError>) -> Void) {
        guard hasMoreFollowers else { return }
        
        page += 1
        loadFollowers(for: username, onStart: onStart ?? {}, completion: completion)
    }
    
    private func processFollowersData(_ newFollowers: [Follower]) {
        if newFollowers.count < 99 {
            hasMoreFollowers = false
        }
        
        followers.append(contentsOf: newFollowers)
    }
    
    func filterFollowers(with searchText: String) {
        guard !searchText.isEmpty else {
            clearFilter()
            return
        }
        
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(searchText.lowercased()) }
    }
    
    func clearFilter() {
        isSearching = false
        filteredFollowers = []
    }
    
    
    func follower(at index: Int) -> Follower? {
        guard index >= 0 && index < currentFollowersList.count else { return nil }
        return currentFollowersList[index]
    }
    
    
    func reset() {
        followers = []
        filteredFollowers = []
        page = 1
        hasMoreFollowers = true
        isSearching = false
    }
} 
