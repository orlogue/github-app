import UIKit

final class UserViewController: RootViewController<UserView> {
    private let userService: UserServiceProtocol
    private let username: String
    private let isInSheetMode: Bool
    private var user: User?
    
    init(username: String, user: User? = nil, userService: UserServiceProtocol = UserService.shared, isInSheetMode: Bool = false) {
        self.username = username
        self.user = user
        self.isInSheetMode = isInSheetMode
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        if isInSheetMode {
            configureNavigationBar()
        }
        if user == nil {
            getUserDetails()
        } else {
            layoutSubviewsHierarchy()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isInSheetMode {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    private func configureNavigationBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func getUserDetails() {
        let loaderViewController = LoadingOverlayViewController()
        self.presentOverlay(loaderViewController)
        
        userService.getUserDetails(for: username) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.dismissOverlay(loaderViewController)
            }
            
            switch result {
            case let .success(user):
                self.user = user
                DispatchQueue.main.async {
                    self.layoutSubviewsHierarchy()
                }
            case let .failure(networkError):
                self.presentAlert(title: networkError.message.title, description: networkError.message.description) {
                    self.dismissVC()
                }
            }
        }
    }
    
    private func layoutSubviewsHierarchy() {
        if let user {
            let userHeaderVC = UserHeaderViewController(user: user)
            addChildViewController(userHeaderVC)
            
            NSLayoutConstraint.activate([
                userHeaderVC.view.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                userHeaderVC.view.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                userHeaderVC.view.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                userHeaderVC.view.heightAnchor.constraint(greaterThanOrEqualToConstant: 220)
            ])
        }
    }
    
    @objc
    func dismissVC() {
        dismiss(animated: true)
    }
}
