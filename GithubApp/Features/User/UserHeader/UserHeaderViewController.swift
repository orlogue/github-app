import UIKit

final class UserHeaderViewController: RootViewController<UserHeaderView> {
    private let user: User?
    private let imageService: ImageServiceProtocol
    
    init(user: User, imageService: ImageServiceProtocol = ImageService.shared) {
        self.user = user
        self.imageService = imageService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
    }
    
    private func configureData() {
        guard let user else { return }
        
        let userHeaderDTO = UserHeaderDTO(avatarImage: nil, login: user.login, name: user.name, location: user.location, bio: user.bio)
        
        let _ = imageService.loadImage(from: user.avatarUrl) { [weak self] image in
            self?.rootView.setAvatarImage(image)
        }
        
        rootView.configure(with: userHeaderDTO)
    }
}
