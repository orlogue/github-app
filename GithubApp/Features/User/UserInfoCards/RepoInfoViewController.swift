import UIKit

final class RepoInfoViewController: UserInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    private func configureSubviews() {
        rootView.leftInfoItem.set(userInfoType: .repos, withCount: user.publicRepos)
        rootView.rightInfoItem.set(userInfoType: .gists, withCount: user.publicGists)

        rootView.actionButton.set(title: "See More", backgroundColor: .accent)
        rootView.actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func actionButtonTapped() {
        delegate?.didTapGithubProfileButton(for: user)
    }
}
