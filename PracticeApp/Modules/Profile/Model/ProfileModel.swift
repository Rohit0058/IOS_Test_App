//
//  ProfileModel.swift
//  PracticeApp
//
//  Created by Rohit Bharti on 28/07/23.
//

import Foundation

struct Profile : Codable {
    var id: Int?
    var name: String?
    var avatar_url: String?
    var company: String?
    var location: String?
    var type: String?
    var bio: String?
    var email: String?
    var followers: Int?
    var following: Int?
    
    enum ProfileCodingKeys : String, CodingKey {
        case id, name, company, bio, email, followers, following, location, type, avatar_url
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ProfileCodingKeys.self)
        self.id = try? values.decodeIfPresent(Int.self, forKey: .id)
        self.name = try? values.decodeIfPresent(String.self, forKey: .name)
        self.avatar_url = try? values.decodeIfPresent(String.self, forKey: .avatar_url)
        self.company = try? values.decodeIfPresent(String.self, forKey: .company)
        self.bio = try? values.decodeIfPresent(String.self, forKey: .bio)
        self.email = try? values.decodeIfPresent(String.self, forKey: .email)
        self.followers = try? values.decodeIfPresent(Int.self, forKey: .followers)
        self.following = try? values.decodeIfPresent(Int.self, forKey: .following)
        self.location = try? values.decodeIfPresent(String.self, forKey: .location)
        self.type = try? values.decodeIfPresent(String.self, forKey: .type)
    }
}
