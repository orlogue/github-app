import UIKit

class PrimaryButton: UIButton {
    var baseBackgroundColor: UIColor?
    
    override var backgroundColor: UIColor? {
        didSet {
            if !isHighlighted {
                baseBackgroundColor = backgroundColor
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: Constants.Button.animationDuration) {
                self.backgroundColor = self.isHighlighted ?
                self.baseBackgroundColor?.withAlphaComponent(0.7) :
                self.baseBackgroundColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, backgroundColor: UIColor) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    func set(title: String, backgroundColor: UIColor)  {
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    private func configureAppearance() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = Constants.View.cornerRadius
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
    }
}
