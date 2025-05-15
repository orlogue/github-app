import Foundation

struct Follower: Codable, Hashable {
    let id: Int
    let login: String
    let avatarUrl: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
