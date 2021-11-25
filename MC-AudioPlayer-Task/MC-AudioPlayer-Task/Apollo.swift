//
//  Apollo.swift
//  MC-AudioPlayer-Task
//
//  Created by Devsisters on 2021/11/25.
//

import Apollo
import Foundation

class Apollo {
    static let shared = Apollo()
    
    let client: ApolloClient
    
    init() {
        client = ApolloClient(url: URL(string: "https://mc-api-dev-1.dev.devsisters.cloud/graphql")!)
    }
}
