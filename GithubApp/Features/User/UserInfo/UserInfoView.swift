import UIKit

class UserInfoView: UIView {
    let stackView = UIStackView()
    let leftInfoItem = UserInfoItemView()
    let rightInfoItem = UserInfoItemView()
    let actionButton = PrimaryButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
        configureStackView()
        layoutSubviewsHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAppearance() {
        layer.cornerRadius = Constants.View.largeCornerRadius
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        let padding = Constants.Padding.small
        layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        [leftInfoItem, rightInfoItem].forEach { stackView.addArrangedSubview($0) }
    }
    
    private func layoutSubviewsHierarchy() {
        [stackView, actionButton].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            actionButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Constants.Padding.small),
            actionButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            actionButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: Constants.Button.smallHeight),
        ])
    }
}
