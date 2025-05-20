import UIKit

class AvatarImageView: UIImageView {
    var placeholderImage = UIImage(named: Constants.Resources.avatarPlaceholderName)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAppearance() {
        layer.cornerRadius = Constants.View.cornerRadius
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func resetImage() {
        image = placeholderImage
    }
}
