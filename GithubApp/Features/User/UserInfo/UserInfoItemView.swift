import UIKit

enum UserInfoType {
    case repos, gists, following, followers
}

class UserInfoItemView: UIView {
    let horizontalView = UIView()
    let symbolImageView = UIImageView()
    let titleLabel = TitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = TitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configureSubviews()
        layoutSubviewsHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(userInfoType: UserInfoType, withCount count: Int) {
        switch userInfoType {
        case .repos:
            symbolImageView.image = UIImage(systemName: Constants.SFSymbols.repo)
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = UIImage(systemName: Constants.SFSymbols.gists)
            titleLabel.text = "Public Gists"
        case .following:
            symbolImageView.image = UIImage(systemName: Constants.SFSymbols.heart)
            titleLabel.text = "Following"
        case .followers:
            symbolImageView.image = UIImage(systemName: Constants.SFSymbols.followers)
            titleLabel.text = "Followers"
        }
        countLabel.text = String(count)
    }
    
    private func configureSubviews() {
        symbolImageView.contentMode = .scaleAspectFit
        symbolImageView.tintColor = .label
    }

    private func layoutSubviewsHierarchy() {
        [symbolImageView, titleLabel].forEach {
            horizontalView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [horizontalView, countLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            horizontalView.topAnchor.constraint(equalTo: topAnchor),
            horizontalView.centerXAnchor.constraint(equalTo: centerXAnchor),
            horizontalView.heightAnchor.constraint(equalToConstant: 20),
            
            symbolImageView.centerYAnchor.constraint(equalTo: horizontalView.centerYAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: horizontalView.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: horizontalView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: horizontalView.trailingAnchor),
            
            countLabel.topAnchor.constraint(equalTo: horizontalView.bottomAnchor, constant: 4),
            countLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
