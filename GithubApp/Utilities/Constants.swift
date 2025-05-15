import UIKit

enum Constants {
    static let defaultAnimationDuration: TimeInterval = 0.25
    static let cornerRadius: CGFloat = 12
    static let sheetCornerRadius: CGFloat = 24

    enum Button {
        static let animationDuration: TimeInterval = 0.15
        static let cornerRadius: CGFloat = Constants.cornerRadius
        static let height: CGFloat = 50
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
    }
    
    enum Resources {
        static let avatarPlaceholderName = "avatar-placeholder"
    }
}
