//
//  ConfigService.swift
//  MC-AudioPlayer-Task
//
//  Created by inae Lee on 2021/11/19.
//

import Foundation
import Moya

final class MusicService {
    static let shared = MusicService()
    static let provider = MoyaProvider<MusicAPI>()

    private init() {}

    func fetchConfigURL(completion: (() -> Void)? = nil) {
        MusicService.provider.request(.getConfigURL) { result in
            switch result {
            case .success(let response):
                do {
                    let data = response.data
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                    if let url = json?["static_url_prefix"] as? String {
                        UserDefaults.staticURL = url
                        completion?()
                    }
                } catch {
                    print("[Decode Erorr] | ", error)
                }
            case .failure(let error):
                print("[Network Error] Config | ", error)
            }
        }
    }

    func fetchPlayList(completion: (([Music]) -> Void)?) {
        MusicService.provider.request(.getPlayList) { result in
            switch result {
            case .success(let response):
                do {
                    let json = try JSONDecoder().decode([Music].self, from: response.data)

                    completion?(json)
                } catch {
                    print("[Decode Erorr] | ", error)
                }

            case .failure(let error):
                print("[Network Error] PlayList | ", error)
            }
        }
    }
}
