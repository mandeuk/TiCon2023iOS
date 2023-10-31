//
//  RegisterFeature.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import SwiftUI
import ComposableArchitecture

struct RegisterFeature: Reducer {
    
    @Dependency(\.registerUser) var registerUser
    
    struct State: Equatable {
        var token: String
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
                return .run { [state] send in
                    let statusCode = try await registerUser.fetch("google", state.token, state.name, state.gender, state.birth)
                    
                    switch(statusCode){
                    case 200:
                        debugPrint("200")
                        await send(.pop)
                        //홈 화면으로
                        break
                    case 403:
                        debugPrint("403")
                        await send(.pop)
                        //회원가입 화면으로
                        //await send(.pushRegisterView)
                        break
                    default:
                        await send(.pop)
                        //await send(.signInFailure)
                        //실패처리
                        break
                    }
                }
                break

            default:
                break
            }
            return .none
        }
    }
}

