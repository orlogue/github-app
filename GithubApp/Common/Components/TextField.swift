import UIKit

class TextField: UITextField {
    let textPadding = UIEdgeInsets(top: 0, left: Constants.Padding.xSmall, bottom: 0, right: Constants.Padding.xSmall)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.clearButtonRect(forBounds: bounds)
        return rect.offsetBy(dx: -Constants.Padding.xXSmall, dy: 0)
    }
    
    private func configureAppearance() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = Constants.Button.cornerRadius
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .left
        font = .preferredFont(forTextStyle: .title3)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 14
        
        backgroundColor = .tertiarySystemBackground
        clearButtonMode = .whileEditing
        autocorrectionType = .no
        returnKeyType = .go
        placeholder = "Enter a username"
    }
}
