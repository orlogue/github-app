import UIKit

final class FollowersInfoViewController: UserInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    private func configureSubviews() {
        rootView.leftInfoItem.set(userInfoType: .following, withCount: user.following)
        rootView.rightInfoItem.set(userInfoType: .followers, withCount: user.followers)
        
        rootView.actionButton.set(title: "Get Followers", backgroundColor: .systemGreen)
        rootView.actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func actionButtonTapped() {
        delegate?.didTapGetFollowersButton(for: user)
    }
}
