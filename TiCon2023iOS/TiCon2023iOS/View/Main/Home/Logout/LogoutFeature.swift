//
//  LogoutFeature.swift
//  TiCon2023iOS
//
//  Created by Inho Lee on 10/30/23.
//

import SwiftUI
import ComposableArchitecture

struct LogoutFeature: Reducer {
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
                return .send(.pop)
                break
            case .pop:
                break
            //default:
            //    break
            }
            return .none
        }
    }
}
