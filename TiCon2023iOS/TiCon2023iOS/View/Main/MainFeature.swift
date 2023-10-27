//
//  MainFeature.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import ComposableArchitecture
import SwiftUI
import Alamofire
import GoogleSignIn
import TCACoordinators

struct MainFeature: Reducer {
    struct State: Equatable {
        static let initialState = State(
            home: .init(),
            chat: .init(),
            selectedTab: .home
        )
        
        var home: HomeFeature.State
        var chat: ChatListFeature.State
        
        var selectedTab: Tab
    }
    
    enum Tab: Hashable {
        case home, chat
    }
    
    enum Action {
        case home(HomeFeature.Action)
        case chat(ChatListFeature.Action)
        
        case tabSelected(Tab)
        
        case popToLoginView
    }
    
    var body: some ReducerOf<Self>{
        Scope(state: \.home, action: /Action.home) {
            HomeFeature()
        }
        Scope(state: \.chat, action: /Action.chat) {
            ChatListFeature()
        }
        
        Reduce<State, Action> { state, action in
            switch action {
            case .tabSelected(let tab):
                state.selectedTab = tab
                break
                
//            case .home(.goToLoginFromSecond): // 자식 Action 감지
//                return .run { send in
//                    await send(.popToLoginView)
//                }
                
            default:
                break
            }
            return .none
        }
    }
}
