import SwiftUI

extension Photo {
    init(photoDict: [String: AnyObject], userDict: [String: AnyObject]) {
        self.init(id: photoDict["id"] as? String ?? "",
                  url: photoDict["url"] as? String ?? "",
                  created_at: photoDict["created_at"] as? String ?? "",
                  updated_at: photoDict["updated_at"] as? String ?? "",
                  color: photoDict["color"] as? String ?? "",
                  description: photoDict["alt_description"] as? String ?? "",
                  urls: photoDict["urls"] as? [String: String] ?? [:],
                  likes: photoDict["likes"] as? Int ?? 0,
                  user: User(id: userDict["id"] as? String ?? "",
                             name: userDict["name"] as? String ?? "",
                             username: userDict["username"] as? String ?? "",
                             bio: userDict["bio"] as? String ?? "",
                             location: userDict["location"] as? String ?? "",
                             profile_image: userDict["profile_image"] as? [String: String] ?? [:]))
    }
}

struct Photo: Identifiable, Codable {
    
    var id: String
    var url: String
    var created_at: String
    var updated_at: String
    var color: String
    var description: String
    var urls: [String: String]
    var likes: Int
    var user: User
    
    
}

extension Photo: Equatable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}

