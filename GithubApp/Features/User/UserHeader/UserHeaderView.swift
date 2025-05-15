import UIKit

final class UserHeaderView: UIView {
    let avatarImage = AvatarImageView(frame: .zero)
    let titleLabel = TitleLabel(textAlignment: .left, fontSize: 32)
    let nameLabel = SecondaryTitleLabel(fontSize: 18)
    let locationImage = UIImageView()
    let locationLabel = SecondaryTitleLabel(fontSize: 18)
    let bioLabel = BodyLabel(textAlignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configureSubviews()
        layoutSubviewsHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with user: UserHeaderDTO) {
        avatarImage.image = user.avatarImage ?? avatarImage.placeholderImage
        titleLabel.text = user.login
        nameLabel.text = user.name
        
        if let location = user.location, !location.isEmpty {
            locationLabel.text = location
            locationImage.isHidden = false
            locationLabel.isHidden = false
        } else {
            locationImage.isHidden = true
            locationLabel.isHidden = true
        }
        
        bioLabel.text = user.bio
    }
    
    func setAvatarImage(_ image: UIImage?) {
        avatarImage.image = image
    }
    
    private func configureSubviews() {
        locationImage.image = UIImage(systemName: Constants.SFSymbols.location)
        locationImage.tintColor = .secondaryLabel
        locationImage.isHidden = true
        locationLabel.isHidden = true
        bioLabel.numberOfLines = 3
    }
    
    private func layoutSubviewsHierarchy() {
        [avatarImage, titleLabel, nameLabel, locationImage, locationLabel, bioLabel].forEach {
            addSubview($0)
        }
        
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        let innerPadding = Constants.Padding.small
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: topAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 110),
            avatarImage.heightAnchor.constraint(equalToConstant: 110),
            
            titleLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: -4),
            titleLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: innerPadding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 32),
            
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 18),
            
            locationImage.bottomAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: -4),
            locationImage.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: innerPadding),
            locationImage.widthAnchor.constraint(equalToConstant: 20),
            locationImage.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: Constants.Padding.xXSmall),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 18 * 1.2),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: innerPadding / 2),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
