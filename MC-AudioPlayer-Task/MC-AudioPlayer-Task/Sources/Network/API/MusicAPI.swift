//
//  ConfigAPI.swift
//  MC-AudioPlayer-Task
//
//  Created by inae Lee on 2021/11/19.
//

import Foundation
import Moya

enum MusicAPI {
    case getConfigURL
    case getPlayList
}

extension MusicAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .getConfigURL:
            return URL(string: BaseAPI.baseURL)!
        case .getPlayList:
            return URL(string: UserDefaults.staticURL)!
        }
    }

    var path: String {
        switch self {
        case .getConfigURL:
            return "/config.json"
        case .getPlayList:
            return "/list.json"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getConfigURL, .getPlayList:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getConfigURL, .getPlayList:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getConfigURL, .getPlayList:
            return ["Content-Type": "application/json"]
        }
    }
}
