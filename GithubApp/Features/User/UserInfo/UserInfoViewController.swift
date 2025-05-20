import UIKit

class UserInfoViewController: RootViewController<UserInfoView> {
    let user: User
    weak var delegate: UserCardActionsDelegate?
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
