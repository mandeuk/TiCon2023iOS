//
//  GlobalFeature.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import ComposableArchitecture

struct GlobalFeature: Reducer {
    struct State: Equatable {
        static let initialState = State()
        
        var globalString: String = ""
    }
    
    enum Action {
        case stringChange(String)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        
        switch action {
        case let .stringChange(text):
            state.globalString = text
            break
            
        }// end of switch
        return .none
    }
}

