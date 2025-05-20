import UIKit

enum Constants {
    enum View {
        static let cornerRadius: CGFloat = 12
        static let largeCornerRadius: CGFloat = 24
    }
    
    enum Button {
        static let animationDuration: TimeInterval = 0.15
        static let height: CGFloat = 50
        static let smallHeight: CGFloat = 44
    }

    enum Padding {
        static let large: CGFloat = 50
        static let medium: CGFloat = 36
        static let small: CGFloat = 16
        static let xSmall: CGFloat = 12
        static let xXSmall: CGFloat = 8
    }

    enum Color {
        static let opaqueBackground: UIColor = .init(red: 0, green: 0, blue: 0, alpha: 0.75)
    }
    
    enum SFSymbols {
        static let location = "mappin.and.ellipse"
        static let repo = "folder"
        static let gists = "text.alignleft"
        static let heart = "heart"
        static let followers = "person.2"
        static let favorite = "star"
        static let favoriteFilled = "star.fill"
    }
    
    enum Resources {
        static let avatarPlaceholderName = "avatar-placeholder"
    }
    
    static let defaultAnimationDuration: TimeInterval = 0.25
}
