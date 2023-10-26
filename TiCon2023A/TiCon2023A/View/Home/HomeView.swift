//
//  HomeView.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    let store: StoreOf<HomeFeature>
    
    init(store: StoreOf<HomeFeature>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Text("메뉴")
                    })
                }
                Text("HomeView")
                
                Spacer()
                
                AsyncImage(url: URL(string: "")) { image in
                    image.resizable()
                } placeholder: {
                    //ProgressView()
                    EmptyView().clipShape(Circle()).background(Color.blue)
                }
                .frame(width: 200, height: 200)
                
                Button(action: {
                    //viewStore.send(.pushNextView)
                }, label: {
                    Text("매칭시작")
                })
                
                Spacer()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .task{
            //self.store.send(.checkSignIn)
        }
        
    }
}

#Preview {
    HomeView(store: Store(initialState: HomeFeature.State.init()) {
        HomeFeature()
    })
}
