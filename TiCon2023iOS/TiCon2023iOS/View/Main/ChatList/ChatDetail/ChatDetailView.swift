//
//  ChatView.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import SwiftUI
import ComposableArchitecture
import ExyteChat

struct ChatDetailView: View {
    let store: StoreOf<ChatDetailFeature>
    
    init(store: StoreOf<ChatDetailFeature>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            VStack {
                HStack {
                    Button(action: {
                        viewStore.send(.pop)
                    },
                           label: {
                        Text("뒤로가기").foregroundColor(.black)
                    })
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                    Spacer()
                }
                .frame(height: 50)
                .background(Color(UIColor(red: (233/255), green: (255/255), blue: (220/255), alpha: 1)))
                
                ChatView(messages: viewStore.messages, didSendMessage: { message in
                    viewStore.send(.sendChat(message))
                })
            }
            
        }
        .toolbar(.hidden, for: .navigationBar)
        .task{
            store.send(.loadChat)
        }
        
    }
}

#Preview {
    ChatDetailView(store: Store(initialState: ChatDetailFeature.State.init(chatNumber: 1)) {
        ChatDetailFeature()
    })
}
