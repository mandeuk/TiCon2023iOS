//
//  MainView.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

struct MainView: View {
    let store: StoreOf<MainFeature>
    
    init(store: StoreOf<MainFeature>) {
        self.store = store
        //await self.store.send(.getUser)
    }
    
    var body: some View {
        WithViewStore(store, observe: \.selectedTab) { viewStore in
            TabView(selection: viewStore.binding(get: { $0 }, send: MainFeature.Action.tabSelected)) {
                HomeView(
                    store: store.scope(
                        state: { $0.home },
                        action: { .home($0) }
                    )
                )
                .tabItem { Text("Home") }
                .tag(MainFeature.Tab.home)
            
                ChatListView(
                    store: store.scope(
                        state: { $0.chat },
                        action: { .chat($0) }
                    )
                )
                .tabItem { Text("Chat") }
                .tag(MainFeature.Tab.chat)
                
            }.onOpenURL { _ in
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
}
#Preview {
    MainView(store: Store(initialState: MainFeature.State.init()) {
        MainFeature()
    })
}
