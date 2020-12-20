import SwiftUI
import Combine

struct RemoteImage: View {
    @ObservedObject var imageDownloader: ImageDownloader

    init(imageUrl: String) {
        imageDownloader = ImageDownloader(imageURL: imageUrl)
    }

    var body: some View {
        
        Image(uiImage: UIImage(data: imageDownloader.data) ?? UIImage())
            .renderingMode(.original)
            .resizable()
            .scaledToFill()
        
    }
}

class ImageDownloader: ObservableObject {
      
    let objectWillChange = PassthroughSubject<Data, Never>()
    var data = Data()

    init(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }

            DispatchQueue.main.async {
                self.objectWillChange.send(data)
                self.data = data }

            }.resume()
    }
}
