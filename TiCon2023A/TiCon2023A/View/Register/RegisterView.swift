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
    @StateObject var viewModel = ProfileModel()
    
    init(store: StoreOf<RegisterFeature>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            VStack(alignment:.center) {
                HStack {
                    Button(action: {
                        viewStore.send(.pop)
                    },
                           label: {
                        Text("뒤로가기").foregroundColor(.black)
                    })
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    
                    Spacer()
                }
                .frame(height: 50)
                .background(Color(UIColor(red: (233/255), green: (255/255), blue: (220/255), alpha: 1)))
                
                
                Spacer()
                
//                AsyncImage(url: URL(string: ""))
//                    .frame(width: 200, height: 200)
//                    .foregroundColor(Color.clear)
//                    .background(Color(UIColor(red: (227/255), green: (245/255), blue: (255/255), alpha: 1)))
//                    .clipShape(Circle())
                
                EditableCircularProfileImage(viewModel: viewModel, width: 200, height: 200)
                
                
                VStack (spacing: 20) {
                    TextField("", text: viewStore.binding(get: {$0.name}, send: RegisterFeature.Action.nameChange), prompt: Text("이름").foregroundColor(.black))
                        .frame(minHeight: 50, alignment: .center)
                        .background(Color(UIColor(red: (227/255), green: (245/255), blue: (255/255), alpha: 1)))
                        .multilineTextAlignment(.center)
                    
                    TextField("", text: viewStore.binding(get: {$0.gender}, send: RegisterFeature.Action.genderChange), prompt: Text("성별").foregroundColor(.black))
                        .frame(minHeight: 50, alignment: .center)
                        .background(Color(UIColor(red: (227/255), green: (245/255), blue: (255/255), alpha: 1)))
                        .multilineTextAlignment(.center)
                    
                    TextField("", text: viewStore.binding(get: {$0.birth}, send: RegisterFeature.Action.birthChange), prompt: Text("나이").foregroundColor(.black))
                        .frame(minHeight: 50, alignment: .center)
                        .background(Color(UIColor(red: (227/255), green: (245/255), blue: (255/255), alpha: 1)))
                        .multilineTextAlignment(.center)
                }
                .padding(20.0)
                
                Button(action: {
                    viewStore.send(.register)
                }, label: {
                    Text("회원가입").foregroundColor(.black)
                })
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.red.opacity(0.2))
                .padding(20)
                
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
