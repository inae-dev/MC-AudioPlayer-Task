//
//  User.swift
//  MC-AudioPlayer-Task
//
//  Created by Devsisters on 2021/11/25.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String?
    let name: String
    let nickname: String?
    let bio: String
    let profileCoverURL: String?

    enum CodingKeys: String, CodingKey {
        case id, email, name, nickname, bio
        case profileCoverURL = "profileCoverUrl"
    }
}
