import UIKit

class RootViewController<CustomView: UIView>: UIViewController {
    var rootView: CustomView {
        guard let view = view as? CustomView else {
            fatalError("Expected type view: \(CustomView.self). Got: \(type(of: view))")
        }
        
        return view
    }
    
    override func loadView() {
        self.view = CustomView()
    }
}
