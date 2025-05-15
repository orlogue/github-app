import UIKit

final class SearchViewController: RootViewController<SearchView> {
    private let userService: UserServiceProtocol
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func configureInteractions() {
        rootView.usernameTextField.delegate = self
        rootView.submitButton.addTarget(self, action: #selector(pushFollowersViewController), for: .touchUpInside)
        
        createDismissKeyboardTapGesture()
    }
    
    @objc
    private func pushFollowersViewController() {
        guard let username = rootView.usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !username.isEmpty else {
            presentAlert(title: "Invalid username", description: "The username you entered is empty. Please write some symbols", buttonTitle: "Got it!")
            return
        }
        
        userService.getUserDetails(for: username) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case let .success(user):
                DispatchQueue.main.async {
                    let userViewController = UserViewController(username: username, user: user)
                    self.navigationController?.pushViewController(userViewController, animated: true)
                }
            case let .failure(error):
                self.presentAlert(title: error.message.title, description: error.message.description)
            }
        }
    }
    
    private func createDismissKeyboardTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersViewController()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return !string.contains(" ")
    }
}
