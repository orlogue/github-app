import UIKit

final class AlertContentView: UIView {
    lazy var titleLabel: TitleLabel = {
        let label = TitleLabel(textAlignment: .center, fontSize: 20)
        label.text = "Something went wrong"
        return label
    }()
    
    lazy var messageLabel: BodyLabel = {
        let label = BodyLabel(textAlignment: .center)
        label.text = "Unexpected error occured"
        return label
    }()
    
    lazy var actionButton = PrimaryButton(title: "OK", backgroundColor: .systemPink)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
        layoutSubviewsHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureAppearance() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 18
        layer.borderWidth = 2
        layer.borderColor = UIColor.tertiarySystemBackground.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        layoutMargins = UIEdgeInsets(top: Constants.Padding.small, left: Constants.Padding.small, bottom: Constants.Padding.small, right: Constants.Padding.small)
    }

    private func layoutSubviewsHierarchy() {
        [titleLabel, messageLabel, actionButton].forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),

            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            messageLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -24),

            actionButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            actionButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: Constants.Button.height)
        ])
    }
}
