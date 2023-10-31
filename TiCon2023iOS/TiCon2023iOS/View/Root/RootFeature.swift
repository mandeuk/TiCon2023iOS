//
//  RootFeature.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

struct RootFeature: Reducer {
    struct State: Equatable, IndexedRouterState {
        var routes: [Route<ScreenFeature.State>]
        
        public init(routes: [Route<ScreenFeature.State>] = [.root(.login(.init()), embedInNavigationView: true)]) {
            self.routes = routes
        }
    }
    
    enum Action: IndexedRouterAction {
        case routeAction(Int, action: ScreenFeature.Action)
        case updateRoutes([Route<ScreenFeature.State>])
    }
    
    public struct RootEnvironment {
    }
    
    var body: some ReducerOf<Self> {
        
        Reduce<State, Action> { state, action in
            switch action {
                // MAIN
            case .routeAction(_, .main(.popToLoginView))://Action을 감지하는 부분으로 추측됨
                state.routes.popTo(.login(.init()))
                break
                
                
                // LOGIN
            case .routeAction(_, .login(.pushMainView)):
                state.routes.push(.main(.init()))
                break
                
            case .routeAction(_, .login(.pushRegisterView(let token))):
                state.routes.push(.register(.init(token: token)))
                break
                
            case .routeAction(_, .register(.pop)):
                state.routes.pop(1)
                break
                
                // MAIN - CHAT DETAIL
            case .routeAction(_, .chatDetail(.pop)):
                state.routes.pop(1)
                break
                
                // MAIN - CHAT
            case .routeAction(_, action: .main(.chat(.openChatDetail(let number)))):
                state.routes.push(.chatDetail(.init(chatNumber: number)))
                break
                
                // MAIN - LOGOUT
            case .routeAction(_, .logout(.pop)):
                state.routes.popTo(.login(.init()))
                break
                
                // MAIN - HOME
            case .routeAction(_, action: .main(.home(.pushLogoutView))):
                state.routes.push(.logout(.init()))
                break
                
                
                
//            case .routeAction(_, .intro(.pushLoginView)):
//                state.routes.push(.login(.init()))
//                break
//                
//            case .routeAction(_, action: .main(.chat(.openChatRoom(let idx)))):
//                state.routes.push(.chatRoom(.init()))
//                break
//                
//            case .routeAction(_, action: .chatRoom(.pop)):
//                debugPrint(".pop")
//                state.routes.pop(1)
//                break
//                
//            case .routeAction(_, action: .main(.home(.presentStarDetail))):
//                state.routes.presentSheet(.starDetail(.init()))
//                break
                
            default:
                break
            }
            return .none
        }.forEachRoute {
            ScreenFeature()
        }
    }
}

