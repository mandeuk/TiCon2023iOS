//
//  ChatListView.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import SwiftUI
import ComposableArchitecture

struct ChatListView: View {
    let store: StoreOf<ChatListFeature>
    
    init(store: StoreOf<ChatListFeature>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            VStack {
                Text("ChatListView")
                Button("채팅방"){
                    viewStore.send(.openChatDetail(1))
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .task{
            //self.store.send(.checkSignIn)
        }
        
    }
}

#Preview {
    ChatListView(store: Store(initialState: ChatListFeature.State.init()) {
        ChatListFeature()
    })
}
