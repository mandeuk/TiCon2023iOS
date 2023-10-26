//
//  RegisterView.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import SwiftUI
import ComposableArchitecture

struct RegisterView: View {
    let store: StoreOf<RegisterFeature>
    
    init(store: StoreOf<RegisterFeature>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            VStack {
                HStack(alignment:.top) {
                    Button(action: {
                        viewStore.send(.pop)
                    },
                           label: {
                        Text("뒤로가기")
                    })
                }
                
                Text("RegisterView")
                
                Spacer()
                
                AsyncImage(url: URL(string: "")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200, height: 200)
                
                VStack (spacing: 20) {
                        
                    TextField("", text: viewStore.binding(get: {$0.name}, send: RegisterFeature.Action.nameChange), prompt: Text("이름").foregroundColor(.black))
                        .padding(5)
                        .frame(minHeight: 50, alignment: .center)
                        .background(Color(UIColor(red: (227/255), green: (245/255), blue: (255/255), alpha: 1)))
                        .multilineTextAlignment(.center)
                    
                    TextField("", text: viewStore.binding(get: {$0.gender}, send: RegisterFeature.Action.genderChange), prompt: Text("성별").foregroundColor(.black))
                        .padding(5)
                        .frame(minHeight: 50, alignment: .center)
                        .background(Color(UIColor(red: (227/255), green: (245/255), blue: (255/255), alpha: 1)))
                        .multilineTextAlignment(.center)
                    
                    TextField("", text: viewStore.binding(get: {$0.birth}, send: RegisterFeature.Action.birthChange), prompt: Text("나이").foregroundColor(.black))
                        .padding(5)
                        .frame(minHeight: 50, alignment: .center)
                        .background(Color(UIColor(red: (227/255), green: (245/255), blue: (255/255), alpha: 1)))
                        .multilineTextAlignment(.center)
                        
                    TextField("성별", text: viewStore.binding(get: {$0.gender}, send: RegisterFeature.Action.genderChange)).background(Color(UIColor(red: (227/255), green: (245/255), blue: (255/255), alpha: 1)))
                    TextField("나이", text: viewStore.binding(get: {$0.birth}, send: RegisterFeature.Action.birthChange)).background(Color("#0000ff"))
                    
                }
                .padding(20.0)
                
                Button(action: {
                    viewStore.send(.register)
                }, label: {
                    Text("회원가입")
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
    RegisterView(store: Store(initialState: RegisterFeature.State.init()) {
        RegisterFeature()
    })
}
