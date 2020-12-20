import Foundation

struct UnsplashAPIService {
    
    static let apiKey = "qSppBn4PRzRkSekSRkDdbNq5cAOBu_deWV-0kOPrK7Q"
    
    static func getPhotos(page: Int, username: String = "", completion: @escaping ([Photo]) -> ()) {
        
        var photos = [Photo]()
        
        guard !apiKey.isEmpty else {
            fatalError("Insert your api key from Unsplash.")
        }
        
        guard let url = URL(string: username == "" ? "https://api.unsplash.com/photos/random/?count=6&client_id=\(UnsplashAPIService.apiKey)" : "https://api.unsplash.com/users/\(username.replacingOccurrences(of: " ", with: ""))/photos?page=\(page)&client_id=\(UnsplashAPIService.apiKey)")
        else {
            print("URL is invalid.")
            completion(photos)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                completion(photos)
                return }
            
            do {
                guard let data = data else { return }
                guard let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSArray else { return }
                for i in jsonData {
                    let item = i as? [String: AnyObject] ?? [:]
                    let photo = Photo(photoDict: item, userDict: item["user"] as? [String: AnyObject] ?? [:])
                    photos.append(photo)
                }
                completion(photos)
            } catch {
                print(error.localizedDescription)
                completion(photos)
            }
            
        }.resume()
        
    }
}
