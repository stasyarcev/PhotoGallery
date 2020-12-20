import SwiftUI
import Photos

struct PhotoDetailView: View {
    
    @State var showDetail = false
    @State var bottomState = CGSize.zero
    @State var showFullDetail = false
    
    @State var fullScreen = false
    @State var photoState = CGSize.zero
    @GestureState var magnifyBy = CGFloat(1.0)
    
    var photo: Photo
    @EnvironmentObject var photoStore: PhotoStore
    
    @State var like = false
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .edgesIgnoringSafeArea(.all)
                .animation(.default)
                .foregroundColor(Color.black.opacity(fullScreen ? 1 : 0))
            
            //Text("\(bottomState.height)").offset(y: -300)
                    
            //Photo
            VStack {
                RemoteImage(imageUrl: photo.urls["regular"] ?? "")
                    .frame(width: UIScreen.main.bounds.width * magnifyBy, height: 200 * magnifyBy, alignment: .leading)
                    .padding(.horizontal)
                    .scaleEffect(fullScreen ? 1.3 : 1)
                    .onTapGesture(count: 2, perform: {
                        self.fullScreen.toggle()
                    })
                    .offset(x: photoState.width, y: photoState.height)
                    .gesture(dragging)
                    .gesture(magnification)
                
                Spacer()
            }.padding(.top, fullScreen ? 220 : 180)
            
            // Info
            DeatailInfo(showFullDetail: $showFullDetail, fullScreen: $fullScreen, like: $like, photo: photo)
                .offset(y: bottomState.height)
                .gesture(draggingInfo)
        }
    }
    
    var magnification: some Gesture {
        MagnificationGesture()
            .updating($magnifyBy) { currentState, gestureState, transaction in
                if fullScreen == true {
                    gestureState = currentState
                }
            }
    }
    
    var dragging: some Gesture {
        DragGesture()
            .onChanged { value in
                if fullScreen == true {
                    self.photoState = value.translation
                }
            }
            .onEnded { value in
                self.photoState = .zero
            }
    }
    
    var draggingInfo: some Gesture {
        DragGesture()
            .onChanged { value in
                self.bottomState = value.translation
                if self.showFullDetail {
                    self.bottomState.height += -280
                }
                if self.bottomState.height < -280 {
                    self.bottomState.height = -280
                }
            }
            .onEnded { value in
                if self.bottomState.height > 50 {
                    self.showDetail = false
                }
                if (self.bottomState.height < -100 && !self.showFullDetail) || (self.bottomState.height < -250 && self.showFullDetail) {
                    self.bottomState.height = -280
                    self.showFullDetail = true
                } else {
                    self.bottomState = .zero
                    self.showFullDetail = false
                }
            }
    }
    
    func loadUserPhotos() {
        // this needs to be a different method but it works for now :p
        photoStore.fetch(username: photo.user.name)
    }
    
}
