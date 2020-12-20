import SwiftUI
import Combine

struct HomeView: View {
    
    @EnvironmentObject var photoStore: PhotoStore
    @State var expand = false
    @State var search = ""
    @State var page = 1
    @State var isSearching = false
    @State var searching = ""

    var columns = [
        GridItem(spacing: 0),
        GridItem(spacing: 0)
    ]
    
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(photoStore.photos) { photo in
                            NavigationLink(destination: PhotoDetailView(photo: photo)) {
                                PhotoRow(photo: photo)
                            }
                        }
                    }
                }
            }.onAppear(perform: load)
        }
    }
    
    func load() {
        photoStore.fetch()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
