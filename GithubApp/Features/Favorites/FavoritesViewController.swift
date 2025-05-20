import UIKit

final class FavoritesViewController: RootViewController<FavoritesView> {
    private let imageService: ImageServiceProtocol
    private var favoriteUsers = [FavoriteUser]()
    private var imageLoadingTasks = [String: UUID]()
    
    init(imageService: ImageServiceProtocol = ImageService.shared) {
        self.imageService = imageService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        loadFavorites()
    }
    
    private func configureAppearance() {
        rootView.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
    
    private func loadFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let favoriteUsers):
                self.favoriteUsers = favoriteUsers
                if self.favoriteUsers.isEmpty {
                    self.showCustomEmptyState()
                } else {
                    DispatchQueue.main.async {
                        self.rootView.tableView.reloadData()
                        self.rootView.bringSubviewToFront(self.rootView.tableView)
                    }
                }
            case .failure(let error):
                self.showCustomEmptyState()
                self.presentAlert(title: error.message.title, description: error.message.description)
            }
        }
    }
    
    private func showCustomEmptyState() {
        self.showEmptyState(with: "There's no favorite users. Go add them ^^", in: self.rootView)
    }
    
    deinit {
        imageLoadingTasks.values.forEach { imageService.cancelLoad(for: $0) }
        imageLoadingTasks.removeAll()
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    private func configureCell(cell: FavoriteCell, favoriteUser: FavoriteUser) {
        cell.set(favoriteUser: favoriteUser)
        
        if let taskId = imageLoadingTasks[favoriteUser.username] {
            imageService.cancelLoad(for: taskId)
        }
    
        let taskId = imageService.loadImage(from: favoriteUser.avatarUrl) { [weak self, weak cell] image in
            guard let self else { return }
            guard let cell = cell, cell.username == favoriteUser.username, let image else { return }
            
            cell.setImage(image: image)
            imageLoadingTasks[favoriteUser.username] = nil
        }
        
        if let taskId {
            self.imageLoadingTasks[favoriteUser.username] = taskId
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favoriteUser = favoriteUsers[indexPath.row]
        
        configureCell(cell: cell, favoriteUser: favoriteUser)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let favoriteUser = favoriteUsers[indexPath.row]
        let userViewController = UserLoadingViewController(username: favoriteUser.username)
        navigationController?.pushViewController(userViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favoriteUser = favoriteUsers[indexPath.row]
        favoriteUsers.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .middle)
        PersistenceManager.updateWith(favorite: favoriteUser, actionType: .remove) { [weak self] error in
            guard let self else { return }
            
            if let error {
                self.presentAlert(title: error.message.title, description: error.message.description)
            } else {
                self.loadFavorites()
            }
        }
    }
}
