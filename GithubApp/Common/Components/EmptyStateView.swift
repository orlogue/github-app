import UIKit

class EmptyStateView: UIView {
    let messageView = TitleLabel(textAlignment: .center, fontSize: 24)
    let imageView = UIImageView(image: UIImage(named: "empty-state"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageView.text = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(messageView)
        addSubview(imageView)

        messageView.numberOfLines = 3
        messageView.textColor = .secondaryLabel
        
        messageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            messageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            messageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Padding.medium),
            messageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Padding.medium),
            messageView.heightAnchor.constraint(equalToConstant: 200),
            
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
        ])
    }
}
