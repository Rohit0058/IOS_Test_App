//
//  TableDataStruct.swift
//  PracticeApp
//
//  Created by Rohit Bharti on 26/07/23.
//

import Foundation
import UIKit

struct Users: Codable {
    let url: String?
    let id: Int?
    let user: UserData?
    let body: String?
    let title: String?
    
    enum RootKeys: String, CodingKey {
        case url, id, user, body, title
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: RootKeys.self)
        self.url = try? values.decodeIfPresent(String.self, forKey: .url)
        self.id = try? values.decodeIfPresent(Int.self, forKey: .id)
        self.user = try? values.decodeIfPresent(UserData.self, forKey: .user)
        self.body = try? values.decodeIfPresent(String.self, forKey: .body)
        self.title = try? values.decodeIfPresent(String.self, forKey: .title)
    }
}

struct UserData: Codable {
    let id: Int?
    let login: String?
    let avatarUrl: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case id, login, type
        case avatarUrl = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? values.decodeIfPresent(Int.self, forKey: .id)
        self.login = try? values.decodeIfPresent(String.self, forKey: .login)
        self.avatarUrl = try? values.decodeIfPresent(String.self, forKey: .avatarUrl)
        self.type = try? values.decodeIfPresent(String.self, forKey: .type)
    }
}
