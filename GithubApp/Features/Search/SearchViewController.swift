import UIKit

final class SearchViewController: RootViewController<SearchView> {
    private let userService: UserServiceProtocol
    private var user: User?
    
    init(userService: UserServiceProtocol = UserService.shared) {
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInteractions()
        configureTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func configureInteractions() {
        rootView.submitButton.addTarget(self, action: #selector(goToUserView), for: .touchUpInside)
        
        createDismissKeyboardTapGesture()
    }
    
    private func configureTextField() {
        rootView.usernameTextField.delegate = self
        rootView.usernameTextField.autocapitalizationType = .none
    }
    
    @objc
    private func goToUserView() {
        guard let username = rootView.usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !username.isEmpty else {
            presentAlert(title: "Invalid username", description: "The username you entered is empty. Please write some symbols", buttonTitle: "Got it!")
            return
        }
        
        rootView.endEditing(true)
        loadUser(username) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case let .success(user):
                DispatchQueue.main.async {
                    self.displayUserViewController(user)
                }
            case let .failure(error):
                self.presentAlert(title: error.message.title, description: error.message.description) {
                    self.rootView.usernameTextField.becomeFirstResponder()
                }
            }
        }
    }
    
    private func loadUser(_ username: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
        let loaderViewController = LoadingOverlayViewController()
        presentOverlay(loaderViewController)
        
        userService.getUserDetails(for: username) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.dismissOverlay(loaderViewController)
            }
            
            completion(result)
        }
    }
    
    private func displayUserViewController(_ user: User) {
        let userViewController = UserViewController(user: user)
        navigationController?.pushViewController(userViewController, animated: true)
    }
    
    private func createDismissKeyboardTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        goToUserView()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return !string.contains(" ")
    }
}
