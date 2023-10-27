//
//  RegisterFeature.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import SwiftUI
import ComposableArchitecture

struct RegisterFeature: Reducer {
    struct State: Equatable {
        var name: String = ""
        var gender: String = ""
        var birth: String = ""
    }
    
    enum Action {
        case nameChange(String)
        case genderChange(String)
        case birthChange(String)
        
        case register
        
        // Navigation actions
        case pop
    }
    
    var body: some ReducerOf<Self>{
        Reduce<State, Action> { state, action in
            switch action {
            case let .nameChange(text):
                state.name = text
                break
            case let .genderChange(text):
                state.gender = text
                break
            case let .birthChange(text):
                state.birth = text
                break
                
            case .register:
                break

            default:
                break
            }
            return .none
        }
    }
}

