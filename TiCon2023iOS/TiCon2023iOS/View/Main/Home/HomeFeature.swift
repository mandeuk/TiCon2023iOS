//
//  HomeFeature.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import SwiftUI
import ComposableArchitecture

struct HomeFeature: Reducer {
    struct State: Equatable {
        var password: String = ""
        var isMatching: Bool = false
    }
    
    enum Action {
        case clickMatching
        
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
                
            default:
                break
            }
            return .none
        }
    }
}
