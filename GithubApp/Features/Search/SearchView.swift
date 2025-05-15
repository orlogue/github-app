import UIKit

final class SearchView: UIView {
    lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "gh-logo")
        return view
    }()
    lazy var usernameTextField = TextField()
    lazy var submitButton = PrimaryButton(title: "Continue", backgroundColor: .systemGreen)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layoutSubviewsHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutSubviewsHierarchy() {
        [logoImageView, usernameTextField, submitButton].forEach { addSubview($0) }
        addSubview(logoImageView)
        addSubview(usernameTextField)
        addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Constants.Padding.large),
            usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Padding.large),
            usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Padding.large),
            usernameTextField.heightAnchor.constraint(equalToConstant: Constants.Button.height),
            
            submitButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            submitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Padding.large),
            submitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Padding.large),
            submitButton.heightAnchor.constraint(equalToConstant: Constants.Button.height)
        ])
    }
}
