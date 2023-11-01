//
//  HomeFeature.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import SwiftUI
import ComposableArchitecture

struct HomeFeature: Reducer {
    
    @Dependency(\.getUser) var getUser
    
    struct State: Equatable {
        var name: String = "이름"
        var gender: String = "성별"
        var birth: String = "생일"
        var isMatching: Bool = false
    }
    
    enum Action {
        case clickMatching
        case getUser
        case setUser(baseResponse<UserInfo>)
        
        // Navigation actions
        case pushNextView
        case pushLogoutView
    }
    
    var body: some ReducerOf<Self>{
        Reduce<State, Action> { state, action in
            switch action {
                
            case .clickMatching:
                state.isMatching.toggle()
                break
                
            case .getUser:
                debugPrint("getUser")
                return .run { send in
                    let response = try await getUser.fetch()
                    if (response.statusCode == 200) {
                        await send(.setUser(response))
                    }
                }
                
            case .setUser(let response):
                debugPrint("setUser")
                state.name = response.data?.name ?? "ERR"
                state.gender = response.data?.gender ?? "ERR"
                state.birth = response.data?.birth ?? "ERR"
                break
                
            default:
                break
            }
            return .none
        }
    }
}
