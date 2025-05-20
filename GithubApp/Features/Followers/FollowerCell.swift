import UIKit

final class FollowerCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
    
    private(set) var username: String?

    let avatarImageView = AvatarImageView(frame: .zero)
    let usernameLabel = TitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSubviewsHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.resetImage()
        usernameLabel.text = nil
        username = nil
    }
    
    func setFollower(follower: Follower) {
        username = follower.login
        usernameLabel.text = follower.login
    }
    
    func setImage(image: UIImage) {
        avatarImageView.image = image
    }
    
    private func layoutSubviewsHierarchy() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        let padding = Constants.Padding.xXSmall
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: padding),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
}
