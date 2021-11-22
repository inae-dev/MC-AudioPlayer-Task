//
//  UserDefaults.key+.swift
//  MC-AudioPlayer-Task
//
//  Created by Devsisters on 2021/11/22.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let staticURL = "staticURL"
    }
    
    static var staticURL: String {
        get {
            UserDefaults.standard.string(forKey: Keys.staticURL) ?? ""
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.staticURL)
        }
    }
}
