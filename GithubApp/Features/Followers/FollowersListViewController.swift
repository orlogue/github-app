import UIKit

final class FollowersListViewController: RootViewController<FollowersListView> {
    enum Section {
        case main
    }
    
    private let username: String
    private let model = FollowersModel()
    private let imageService: ImageServiceProtocol
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    private var searchController: UISearchController!
    private var imageLoadingTasks = [String: UUID]()
    
    init(username: String, imageService: ImageServiceProtocol = ImageService.shared) {
        self.username = username
        self.imageService = imageService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        rootView.collectionView.delegate = self
        configureDataSource()
        configureSearchController()
        loadFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.largeTitleDisplayMode = .never
    }

    private func updateSearchBarVisibility(animated: Bool = true) {
        guard let searchController = navigationItem.searchController else { return }
        let shouldHide = model.isEmpty
        
        if animated {
            UIView.transition(with: searchController.searchBar, duration: Constants.defaultAnimationDuration, options: .transitionCrossDissolve) {
                searchController.searchBar.isHidden = shouldHide
            }
        } else {
            searchController.searchBar.isHidden = shouldHide
        }
    }
    
    private func loadFollowers() {
        let loaderViewController = LoadingOverlayViewController()
        
        if let searchController = navigationItem.searchController {
            searchController.searchBar.isHidden = true
        }
        
        model.loadFollowers(for: username,
                            onStart: { [weak self] in
            self?.presentOverlay(loaderViewController)
        }) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.dismissOverlay(loaderViewController)
                self.handleFollowersResult(result)
            }
        }
    }
    
    private func handleFollowersResult(_ result: Result<[Follower], NetworkError>) {
        switch result {
        case .success:
            if model.isEmpty {
                let message = "This user doesn't have any followers. Be the first one!"
                self.showEmptyState(with: message, in: self.view)
                updateSearchBarVisibility()
                return
            }
            updateData(on: model.currentFollowersList)
        case .failure(let error):
            self.presentAlert(title: error.message.title, description: error.message.description) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func configureSearchController() {
        searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a user"
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.isHidden = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: rootView.collectionView) { [weak self] collectionView, indexPath, follower in
            guard let self = self else { return nil }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            
            self.configureCell(cell: cell, follower: follower)
            
            return cell
        }
    }
    
    private func configureCell(cell: FollowerCell, follower: Follower) {
        cell.setFollower(follower: follower)
        
        if let taskId = imageLoadingTasks[follower.login] {
            imageService.cancelLoad(for: taskId)
        }
    
        let taskId = imageService.loadImage(from: follower.avatarUrl) { [weak self, weak cell] image in
            guard let self else { return }
            guard let cell = cell, cell.username == follower.login, let image else { return }
            
            cell.setImage(image: image)
            imageLoadingTasks[follower.login] = nil
        }
        
        if let taskId {
            self.imageLoadingTasks[follower.login] = taskId
        }
    }
    
    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        updateSearchBarVisibility()
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    deinit {
        imageLoadingTasks.values.forEach { imageService.cancelLoad(for: $0) }
        imageLoadingTasks.removeAll()
        model.reset()
    }
}

extension FollowersListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        let loaderViewController = LoadingOverlayViewController()
        
        if offsetY >= (contentHeight - height) {
            model.loadMoreFollowers(for: username) { [weak self] in
                self?.presentOverlay(loaderViewController)
            } completion: { [weak self] result in
                DispatchQueue.main.async {
                    self?.handleFollowersResult(result)
                    self?.dismissOverlay(loaderViewController)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let follower = model.follower(at: indexPath.item) else { return }

        let userViewController = UserLoadingViewController(username: follower.login)
        navigationController?.pushViewController(userViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let follower = model.follower(at: indexPath.item), let taskId = imageLoadingTasks[follower.login] else { return }
        
        imageService.cancelLoad(for: taskId)
        imageLoadingTasks.removeValue(forKey: follower.login)
    }
}

extension FollowersListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text else { return }
        
        model.filterFollowers(with: filter)
        updateData(on: model.currentFollowersList)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        model.clearFilter()
        updateData(on: model.currentFollowersList)
    }
}
