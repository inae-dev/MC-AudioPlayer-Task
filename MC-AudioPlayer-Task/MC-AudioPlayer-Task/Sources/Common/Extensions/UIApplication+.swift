//
//  UIApplication+.swift
//  MC-AudioPlayer-Task
//
//  Created by Devsisters on 2021/11/24.
//

import UIKit

extension UIApplication {
    static var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: { $0.isKeyWindow })
    }
}
