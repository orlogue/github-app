import UIKit

class UserView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAppearance() {
        let padding = Constants.Padding.small
        layoutMargins = UIEdgeInsets(top: padding / 2, left: padding, bottom: padding, right: padding)
    }
}
