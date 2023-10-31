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
        var home: HomeFeature.State = .init()
        var chat: ChatListFeature.State = .init()
        var chatDetail: ChatDetailFeature.State = .init(chatNumber: 0)
        var logout: LogoutFeature.State = .init()
        
        var selectedTab: Tab = .home
    }
    
    enum Tab: Hashable {
        case home, chat
    }
    
    enum Action {
        case home(HomeFeature.Action)
        case chat(ChatListFeature.Action)
        case chatDetail(ChatDetailFeature.Action)
        case logout(LogoutFeature.Action)
        
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
        Scope(state: \.chatDetail, action: /Action.chatDetail, child: {
            ChatDetailFeature()
        })
        
        Reduce<State, Action> { state, action in
            switch action {
            case .tabSelected(let tab):
                state.selectedTab = tab
                break
                
//            case .openChatDetail(let number):
//                break
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
