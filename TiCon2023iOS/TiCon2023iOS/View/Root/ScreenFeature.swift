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
        case register(RegisterFeature.State)
        
        case main(MainFeature.State)
        case chatDetail(ChatDetailFeature.State)
        case logout(LogoutFeature.State)
    }
    enum Action {
        case login(LoginFeature.Action)
        case register(RegisterFeature.Action)
        
        case main(MainFeature.Action)
        case chatDetail(ChatDetailFeature.Action)
        case logout(LogoutFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: /State.login, action: /Action.login) {
            LoginFeature()
        }
        Scope(state: /State.register, action: /Action.register) {
            RegisterFeature()
        }
        Scope(state: /State.main, action: /Action.main) {
            MainFeature()
        }
        Scope(state: /State.chatDetail, action: /Action.chatDetail) {
            ChatDetailFeature()
        }
        Scope(state: /State.logout, action: /Action.logout) {
            LogoutFeature()
        }
    }
}
