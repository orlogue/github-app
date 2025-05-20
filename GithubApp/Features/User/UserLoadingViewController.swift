import UIKit

class UserLoadingViewController: UIViewController {
    let username: String
    private let userService: UserServiceProtocol
    
    init(username: String, userService: UserServiceProtocol = UserService.shared) {
        self.username = username
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        loadUser()
    }
    
    private func loadUser() {
        let loaderViewController = LoadingOverlayViewController()
        presentOverlay(loaderViewController)
        
        userService.getUserDetails(for: username) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.dismissOverlay(loaderViewController)
            }
            
            switch result {
            case let .success(user):
                DispatchQueue.main.async {
                    self.displayUserViewController(user)
                }
            case let .failure(error):
                self.presentAlert(title: error.message.title, description: error.message.description) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    private func displayUserViewController(_ user: User) {
        let userViewController = UserViewController(user: user)
        
        if let navigationController = self.navigationController {
            var viewControllers = navigationController.viewControllers
            if let index = viewControllers.firstIndex(of: self) {
                viewControllers[index] = userViewController
                navigationController.setViewControllers(viewControllers, animated: false)
            }
        } else {
            userViewController.modalPresentationStyle = .fullScreen
            present(userViewController, animated: true)
        }
    }
}
