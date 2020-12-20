import SwiftUI

struct User: Identifiable, Codable {
    var id: String
    var name: String
    var username: String
    var bio: String
    var location: String
    var profile_image: [String: String]
}
