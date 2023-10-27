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
                    },
                           label: {
                        Text("메뉴").foregroundColor(.black)
                    })
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                }
                .frame(height: 50)
                .background(Color(UIColor(red: (233/255), green: (255/255), blue: (220/255), alpha: 1)))
                
                Spacer()
                
                AsyncImage(url: URL(string: ""))
                    .frame(width: 200, height: 200)
                    .foregroundColor(Color.clear)
                    .background(Color(UIColor(red: (227/255), green: (245/255), blue: (255/255), alpha: 1)))
                    .clipShape(Circle())
                
                Spacer()
                
                Text ("이름 / 성별 / 생년월일")
                
                Spacer()
                
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
