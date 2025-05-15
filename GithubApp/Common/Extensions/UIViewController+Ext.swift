import UIKit

extension UIViewController {
    func presentAlert(title: String, description: String?, buttonTitle: String = "Got it!", onCompleted: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertViewController = AlertViewController(title: title, description: description, buttonTitle: buttonTitle, onCompleted: onCompleted)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }
    
    func addChildViewController(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.view.frame = view.bounds
        child.didMove(toParent: self)
    }
    
    func removeChildViewController(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
    func presentOverlay(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.view.frame = view.bounds
        child.view.alpha = 0
        child.didMove(toParent: self)
        
        UIView.animate(withDuration: Constants.defaultAnimationDuration) {
            child.view.alpha = 1
        }
    }
    
    func dismissOverlay(_ child: UIViewController) {
        child.willMove(toParent: nil)
        UIView.animate(withDuration: Constants.defaultAnimationDuration, animations: {
            child.view.alpha = 0
        }) { _ in
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
    func showEmptyState(with message: String, in view: UIView) {
        let emptyStateView = EmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    func setSearchFocusedAppearance(_ isFocused: Bool) {
        guard let navigationBar = navigationController?.navigationBar else { return }
        
        if isFocused {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        } else {
            let standardAppearance = UINavigationBarAppearance()
            standardAppearance.configureWithTransparentBackground()
            standardAppearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            standardAppearance.backgroundColor = .systemBackground.withAlphaComponent(0.7)
            
            #warning("Fix disappearance of a bottom line")
            let edgeAppearance = UINavigationBarAppearance()
            edgeAppearance.configureWithOpaqueBackground()
            edgeAppearance.backgroundColor = .clear
            edgeAppearance.shadowColor = nil
            
            navigationBar.standardAppearance = standardAppearance
            navigationBar.scrollEdgeAppearance = edgeAppearance
        }
    }
}
