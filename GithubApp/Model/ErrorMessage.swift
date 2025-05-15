import Foundation

struct ErrorMessage {
    let title: String
    let description: String?
    
    init(title: String) {
        self.title = title
        self.description = nil
    }
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}
