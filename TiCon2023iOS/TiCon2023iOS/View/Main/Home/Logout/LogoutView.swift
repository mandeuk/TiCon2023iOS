//
//  LogoutView.swift
//  TiCon2023iOS
//
//  Created by Inho Lee on 10/30/23.
//

import SwiftUI
import ComposableArchitecture

struct LogoutView: View {
    let store: StoreOf<LogoutFeature>
    
    init(store: StoreOf<LogoutFeature>) {
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
                
                Spacer()
                
                Button(action: {
                    viewStore.send(.logout)
                }, label: {
                    Text("로그아웃")
                        .frame(width: 200, height: 50)
                        .foregroundColor(Color.black)
                        .background(Color.red.opacity(0.2))
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
