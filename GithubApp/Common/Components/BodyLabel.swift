import UIKit

class BodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    private func configureAppearance() {
        textColor = .secondaryLabel
        font = .preferredFont(forTextStyle: .body)
        lineBreakMode = .byWordWrapping
        adjustsFontSizeToFitWidth = true
        numberOfLines = 0
        minimumScaleFactor = 0.8
        translatesAutoresizingMaskIntoConstraints = false
    }
}
