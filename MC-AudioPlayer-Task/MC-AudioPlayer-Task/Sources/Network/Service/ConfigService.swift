//
//  ConfigService.swift
//  MC-AudioPlayer-Task
//
//  Created by inae Lee on 2021/11/19.
//

import Foundation
import Moya

final class ConfigService {
    static let shared = ConfigService()
    static let provider = MoyaProvider<ConfigAPI>()

    private init() {}

    func fetchConfigURL(completion: @escaping (() -> Void)) {
        ConfigService.provider.request(.getConfigURL) { result in
            switch result {
            case .success(let response):
                do {
//                    let json = try JSONSerialization.jsonObject(with: response, options: []) as? [String: Any]
//
//                    if let url = json["static_url_prefix"] as? String {
//                        print(url)
//                    }

                } catch {
                    print("Decode Erorr", error)
                }
            case .failure(let error):
                print("Network Error", error)
            }
        }
    }
}
