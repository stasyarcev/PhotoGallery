import SwiftUI

struct PhotoRow: View {
    
    var photo: Photo
    
    var body: some View {
        
        return VStack(alignment: .leading) {
            PhotoRowImageView(photo: photo).shadow(radius: 8)
        }.frame(width: UIScreen.main.bounds.width)
        
    }
    
}
