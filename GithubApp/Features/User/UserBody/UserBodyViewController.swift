import UIKit
import SafariServices

protocol UserCardActionsDelegate: AnyObject {
    func didTapGithubProfileButton(for user: User)
    func didTapGetFollowersButton(for user: User)
}

class UserBodyViewController: RootViewController<UserBodyView> {
    private var childControllers = [UIViewController]()
    private(set) var user: User
    private lazy var favoriteUserDTO: FavoriteUser = {
        return FavoriteUser(username: user.login, avatarUrl: user.avatarUrl)
    }()
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        configureNavigationBar()
        layoutSubviewsHierarchy()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if navigationItem.rightBarButtonItem == nil {
            configureNavigationBar()
        } else {
            updateFavoriteNavigationButton()
        }
    }
    
    private func configureNavigationBar() {
        let iconName = getFavoriteIconImageName()
        let addToFavoritesButton = UIBarButtonItem(image: UIImage(systemName: iconName),
                                                   style: .done,
                                                   target: self,
                                                   action: #selector(toggleFavorite))
        navigationItem.rightBarButtonItem = addToFavoritesButton
    }
    
    private func updateFavoriteNavigationButton() {
        let iconName = getFavoriteIconImageName()
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: iconName)
    }
    
    @objc
    private func toggleFavorite() {
        PersistenceManager.updateWith(favorite: favoriteUserDTO, actionType: .none) { [weak self] error in
            guard let self else { return }
            
            let feedbackGenerator = UINotificationFeedbackGenerator()
            feedbackGenerator.prepare()
            
            if let error {
                feedbackGenerator.notificationOccurred(.error)
                self.presentAlert(title: error.message.title, description: error.message.description)
            } else {
                DispatchQueue.main.async {
                    feedbackGenerator.notificationOccurred(.success)
                    self.updateFavoriteNavigationButton()
                }
            }
        }
    }
    
    private func getFavoriteIconImageName() -> String {
        let isUserAlreadyFavorite = PersistenceManager.isUserAlreadyFavorite(favoriteUserDTO)
        return isUserAlreadyFavorite ? Constants.SFSymbols.favoriteFilled : Constants.SFSymbols.favorite
    }
    
    private func configureViewControllers() {
        removeAllChildControllers()
        
        let headerVC = UserHeaderViewController(user: user)
        
        let repoInfoVC = RepoInfoViewController(user: user)
        repoInfoVC.delegate = self
        
        let followersVC = FollowersInfoViewController(user: user)
        followersVC.delegate = self
        
        let footerVC = UserFooterViewController(dateString: user.createdAt)
        
        [headerVC, repoInfoVC, followersVC, footerVC].forEach { addChildVC($0) }
    }
    
    private func layoutSubviewsHierarchy() {
        for (index, viewController) in childControllers.enumerated() {
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                viewController.view.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                viewController.view.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            ])
            
            if index == 0 {
                viewController.view.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
            } else {
                viewController.view.topAnchor.constraint(equalTo: childControllers[index - 1].view.bottomAnchor, constant: Constants.Padding.xSmall).isActive = true
            }
            
            if index == childControllers.count - 1 {
                viewController.view.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).priority = .defaultLow
            }
        }
    }
    
    private func addChildVC(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
        childControllers.append(child)
    }
    
    private func removeChildVC(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
    private func removeAllChildControllers() {
        childControllers.forEach {
            removeChildVC($0)
        }
        childControllers.removeAll()
    }
    
    @objc
    func dismissVC() {
        dismiss(animated: true)
    }
}

extension UserBodyViewController: UserCardActionsDelegate {
    func didTapGithubProfileButton(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            self.presentAlert(title: "Invalid URL", description: "The URL attached to this user is invalid.")
            return
        }
        
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .systemGreen
        present(safariViewController, animated: true)
    }
    
    func didTapGetFollowersButton(for user: User) {
        let followersViewController = FollowersListViewController(username: user.login)
        followersViewController.title = "\(user.login)'s followers"
        navigationController?.pushViewController(followersViewController, animated: true)
    }
}
