import SwiftUI

struct DeatailInfo: View {
    @Binding var showFullDetail: Bool
    @Binding var fullScreen: Bool
    @Binding var like: Bool
    var photo: Photo
    
    var body: some View {
        VStack(spacing: 10) {
            
            HStack {
                Spacer()
                //Avatar
                ZStack {
                    Image(systemName: "person")
                        .frame(width: 60, height: 60)
                        .background(Color.black.opacity(0.07))
                        .clipShape(Circle())
                    RemoteImage(imageUrl: photo.user.profile_image["large"] ?? "")
                        .frame(width: 100, height: 80, alignment: .leading)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }
                Spacer()
                //Detail header
                VStack(alignment: .leading, spacing: 5) {
                    Text(photo.description.capitalized)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                    HStack {
                        Text(photo.user.name)
                            .font(.footnote)
                            .padding(.trailing, 40)
                        Circle()
                            .frame(width: 5, height: 5)
                        
                        Spacer()
                    }
                }
                Spacer()
            }
            Group {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(photo.user.location)
                        }
                        HStack {
                            Text("Created: ")
                                .fontWeight(.bold)
                            HStack(spacing: 0) {
                                Text(photo.created_at.byWords[2].prefix(2))
                                Text(".")
                                Text(photo.created_at.byWords[1])
                                Text(".")
                                Text(photo.created_at.byWords[0])
                            }
                            Text("Uploaded: ")
                                .fontWeight(.bold)
                            HStack(spacing: 0) {
                                Text(photo.updated_at.byWords[2].prefix(2))
                                Text(".")
                                Text(photo.updated_at.byWords[1])
                                Text(".")
                                Text(photo.updated_at.byWords[0])
                            }
                        }.font(.footnote)
                    }
                    Spacer()
                }.padding(.leading)
                
                HStack {
                    Text(photo.user.bio)
                    Spacer()
                }
                .padding(.leading)
                .font(.subheadline)
                .lineSpacing(4)
                
                Button(action: {
                    self.like.toggle()
                }) {
                    VStack {
                        Image(systemName: self.like == false ? "suit.heart" : "suit.heart.fill")
                            .foregroundColor(Color(hex: photo.color))
                            .font(.system(size: 50))
                        Text(String(self.like == false ? photo.likes : photo.likes+1))
                    }
                }
                .font(.title)
                
                Text("Color: \(photo.color)")
                    .frame(width: UIScreen.main.bounds.width, height: 50)
                    .foregroundColor(Color(hex: photo.color))
                    .background(Color(hex: photo.color))
            }.opacity(showFullDetail ? 1 : 0)
            
            Spacer()
        }
        .padding(.top, 8)
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
        .background(Color.white)
        .shadow(radius: 10)
        .animation(.default)
        .opacity(fullScreen ? 0 : 1)
        .offset(y: fullScreen ? 900 : 550)
    }
}
