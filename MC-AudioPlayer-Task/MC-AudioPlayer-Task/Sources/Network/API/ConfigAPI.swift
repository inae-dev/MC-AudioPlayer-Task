//
//  ConfigAPI.swift
//  MC-AudioPlayer-Task
//
//  Created by inae Lee on 2021/11/19.
//

import Foundation
import Moya

enum ConfigAPI {
    case getConfigURL
}

extension ConfigAPI: TargetType {
    var baseURL: URL {
        URL(string: BaseAPI.baseURL)!
    }

    var path: String {
        switch self {
        case .getConfigURL:
            return "/config.json"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getConfigURL:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getConfigURL:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getConfigURL:
            return ["Content-Type": "application/json"]
        }
    }
}
