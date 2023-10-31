//
//  ChatFeature.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import SwiftUI
import ComposableArchitecture
import ExyteChat

struct ChatDetailFeature: Reducer {
    struct State: Equatable {
        var chatNumber: Int
        var messages: [Message] = []
        var password: String = ""
        var msgId: Int = 0
    }
    
    enum Action {
        case loadChat
        case sendChat(DraftMessage)
        case setChatNumber(Int)
        // Navigation actions
        case pop
        case pushNextView
    }
    
    var body: some ReducerOf<Self>{
        Reduce<State, Action> { state, action in
            switch action {
                
            case let .sendChat(message):
                
                state.messages.append(Message(id: "\(state.msgId)",  user: User(id: "aa", name: "name", avatarURL: nil, isCurrentUser: true), text: message.text ))
                state.msgId += 1
                debugPrint("send msg : \(message.text)")
                break
                
            case let .setChatNumber(number):
                debugPrint("setChatNumber : \(number)")
                return .send(.loadChat)
                
            case .loadChat:
                debugPrint("LoadChat: \(state.chatNumber)")
                break
                
            default:
                break
            }
            return .none
        }
    }
}
