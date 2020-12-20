import SwiftUI
import Combine

class PhotoStore: ObservableObject {
    
    let objectWillChange = PassthroughSubject<PhotoStore, Never>()

    var photos: [Photo] = []
    var userPhotos: [Photo] = []
    var page: Int = 1
    
    func fetch(username: String = "") {
        UnsplashAPIService.getPhotos(page: page, username: username) { (fetchedPhotos) in
            DispatchQueue.main.async {
                self.objectWillChange.send(self)
                if username == "" {
                    self.photos = fetchedPhotos
                } else {
                    self.userPhotos = fetchedPhotos
                }
            }
        }
    }
    
    func fetchMore(username: String = "") {
        page += 1
        var newPhotos = photos
        UnsplashAPIService.getPhotos(page: page, username: username) { (fetchedPhotos) in
            DispatchQueue.main.async {
                self.objectWillChange.send(self)
                fetchedPhotos.forEach({
                    if !newPhotos.contains($0) {
                        newPhotos.append($0)
                    }
                })
                self.photos = newPhotos
            }
        }
    }
    
}
