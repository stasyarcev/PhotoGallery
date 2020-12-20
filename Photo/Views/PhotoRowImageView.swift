import SwiftUI

struct PhotoRowImageView: View {
    
    var photo: Photo
    
    var body: some View {
        
        return VStack {
            RemoteImage(imageUrl: photo.urls["regular"] ?? "")
                .frame(width: (UIScreen.main.bounds.width - 32)/2, height: 250, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
    }
}
