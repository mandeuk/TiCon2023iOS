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
    }
    
    enum Action {
        
        // Navigation actions
        case pushNextView
    }
    
    var body: some ReducerOf<Self>{
        Reduce<State, Action> { state, action in
            switch action {
                
                
            default:
                break
            }
            return .none
        }
    }
}
