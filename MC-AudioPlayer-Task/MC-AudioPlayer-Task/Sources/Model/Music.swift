//
//  Music.swift
//  MC-AudioPlayer-Task
//
//  Created by inae Lee on 2021/11/23.
//

import Foundation

// MARK: - Music

struct Music: Codable {
    let title, musicDescription, audioURL, imageURL, updatedAt: String?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case title
        case musicDescription = "description"
        case audioURL = "audio_url"
        case imageURL = "image_url"
        case updatedAt = "updated_at"
        case userID = "user_id"
    }
}
