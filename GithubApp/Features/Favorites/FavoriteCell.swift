import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseID = "FavoriteCell"
    
    private(set) var username: String?

    let avatarImageView = AvatarImageView(frame: .zero)
    let usernameLabel = TitleLabel(textAlignment: .left, fontSize: 20)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureAppearance()
        layoutSubviewsHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.resetImage()
        usernameLabel.text = nil
        username = nil
    }
    
    func set(favoriteUser: FavoriteUser) {
        username = favoriteUser.username
        usernameLabel.text = favoriteUser.username
    }
    
    func setImage(image: UIImage) {
        avatarImageView.image = image
    }
    
    private func configureAppearance() {
        accessoryType = .disclosureIndicator
    }

    private func layoutSubviewsHierarchy() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        let padding = Constants.Padding.small
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            
            usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
