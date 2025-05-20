import UIKit

class UserFooterViewController: UIViewController {
    let formattedDateString: String
    let dateLabel = BodyLabel(textAlignment: .center)
    
    init(dateString: String) {
        self.formattedDateString = dateString.convertToDateDisplayFormat(.monthYear)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        layoutSubviewsHierarchy()
    }
    
    private func configureSubviews() {
        dateLabel.text = "Since \(formattedDateString)"
    }
    
    private func layoutSubviewsHierarchy() {
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.Padding.xXSmall),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
