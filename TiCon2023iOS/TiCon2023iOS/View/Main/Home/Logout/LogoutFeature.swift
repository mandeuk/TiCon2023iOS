//
//  LogoutFeature.swift
//  TiCon2023iOS
//
//  Created by Inho Lee on 10/30/23.
//

import SwiftUI
import ComposableArchitecture

struct LogoutFeature: Reducer {
    @AppStorage("didLogout") private var didLogout: Bool = false
    @Dependency(\.logout) var logout
    
    struct State: Equatable {
        var password: String = ""
    }
    
    enum Action {
        case logout
        
        // Navigation actions
        case pop
    }
    
    var body: some ReducerOf<Self>{
        Reduce<State, Action> { state, action in
            switch action {
            case .logout:
                debugPrint("Logout clicked")
                didLogout = true
                return .run {send in
                    let response = try await logout.fetch()
                    if (response) {
                        await send(.pop)
                    } else {
                        await send(.pop)
                    }
                }
                
            case .pop:
                break
            //default:
            //    break
            }
            return .none
        }
    }
}
