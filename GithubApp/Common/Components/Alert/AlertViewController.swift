import UIKit

class AlertViewController: UIViewController {
    typealias Closure = () -> Void
    
    lazy var contentView = AlertContentView()
    
    private let alertTitle: String?
    private let message: String?
    private let buttonTitle: String?
    private let oncompletion: Closure?
    
    init(title: String, description: String?, buttonTitle: String, oncompletion: Closure? = nil) {
        self.alertTitle = title
        self.message = description
        self.buttonTitle = buttonTitle
        self.oncompletion = oncompletion
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.opaqueBackground
        configureContentView()
        configureSubviews()
        createTapRecognizer()
    }

    private func configureContentView() {
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Padding.medium),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Padding.medium),
        ])
    }
    
    private func configureSubviews() {
        contentView.titleLabel.text = alertTitle

        contentView.messageLabel.text = message

        contentView.actionButton.setTitle(buttonTitle, for: .normal)
        contentView.actionButton.addTarget(self, action: #selector(onDismiss), for: .touchUpInside)
    }
    
    private func createTapRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onDismiss))
        view.addGestureRecognizer(tapRecognizer)
        tapRecognizer.delegate = self
    }
    
    @objc func onDismiss() {
        dismiss(animated: true)
        oncompletion?()
    }
}

extension AlertViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        gestureRecognizer.view == touch.view
    }
}
