import UIKit

protocol ImageServiceProtocol {
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) -> UUID?
    func cancelLoad(for uuid: UUID)
}

final class ImageService: ImageServiceProtocol {
    static let shared = ImageService()
    private let cache = NSCache<NSURL, UIImage>()
    private var runningRequests = [UUID:URLSessionDataTask]()
    
    private init() {}
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) -> UUID? {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return nil
        }

        if let cachedImage = cache.object(forKey: url as NSURL) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return nil
        }
        
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self else { return }
            
            defer { self.runningRequests.removeValue(forKey: uuid) }
            
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == StatusCode.ok else { return }
            
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            self.cache.setObject(image, forKey: url as NSURL)
            DispatchQueue.main.async {
                completion(image)
            }
        }
        
        task.resume()
        runningRequests[uuid] = task
        
        return uuid
    }
    
    func cancelLoad(for uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}
