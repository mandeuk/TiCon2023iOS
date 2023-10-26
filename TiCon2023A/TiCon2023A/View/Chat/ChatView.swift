//
//  ChatView.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import SwiftUI
import ComposableArchitecture

struct ChatView: View {
    let store: StoreOf<ChatFeature>
    
    init(store: StoreOf<ChatFeature>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            VStack {
                Text("ChatView")
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .task{
            //self.store.send(.checkSignIn)
        }
        
    }
}

#Preview {
    ChatView(store: Store(initialState: ChatFeature.State.init()) {
        ChatFeature()
    })
}
