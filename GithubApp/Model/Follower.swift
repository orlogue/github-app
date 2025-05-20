import Foundation

struct Follower: Codable, Identifiable, Hashable {
    let id: Int
    let login: String
    let avatarUrl: String
}
