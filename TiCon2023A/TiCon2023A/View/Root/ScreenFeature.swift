//
//  ScreenFeature.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import ComposableArchitecture

struct ScreenFeature: Reducer {
    enum State: Equatable {
        case login(LoginFeature.State)
        case main(MainFeature.State)
    }
    enum Action {
        case login(LoginFeature.Action)
        case main(MainFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: /State.login, action: /Action.login) {
            LoginFeature()
        }
        Scope(state: /State.main, action: /Action.main) {
            MainFeature()
        }
    }
}
