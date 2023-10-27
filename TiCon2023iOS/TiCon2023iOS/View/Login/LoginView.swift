//
//  LoginView.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import SwiftUI
import ComposableArchitecture
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices

struct LoginView: View {
    let store: StoreOf<LoginFeature>
    let appleSignInController: SignInAppleController
    
    @AppStorage("currentLoginPlatform") var currentLoginPlatform = ""
    @AppStorage("token") var token = ""
    
    init(store: StoreOf<LoginFeature>) {
        self.store = store
        self.appleSignInController = .init(store: store)
    }
    
    //var setSignInState: ( (Bool) -> Void )?
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("LoginView")
                
                Button("GoToMain"){
                    debugPrint("MainView GoToMain")
                    viewStore.send(.pushMainView)
                }
                Button("GoToRegister"){
                    debugPrint("MainView GoToRegister")
                    viewStore.send(.pushRegisterView)
                }
                // 구글 로그인 버튼
                GoogleSignInButton(action: {
                    guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
                    
                    // 구글 로그인 함수는 비동기로 실행됨
                    GIDSignIn.sharedInstance.signIn(
                        withPresenting: presentingViewController) { signInResult, error in
                            if (error != nil) {
                                // 오류 발생 시
                                debugPrint("LoginFeature, .googleSignIn, ERROR: \(error?.localizedDescription ?? "알 수 없는 오류")")
                                return
                            }
                            guard let result = signInResult else {
                                // 결과값이 없을 때
                                debugPrint("LoginFeature, .googleSignIn, 결과 값이 존재하지 않습니다")
                                return
                            }
                            
                            currentLoginPlatform = LoginPlatform.google.rawValue
                            token = (result.user.idToken?.tokenString ?? "")
                            
                            debugPrint("LoginFeature, .googleSignIn, idToken: \(result.user.idToken?.tokenString ?? "no")")
                            
                            // 서버에 로그인 요청
                            viewStore.send(.googleSignIn)
                        }
                })
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
//                // 애플 로그인 커스텀 버튼
//                Button(action: {
//                    appleSignInController.appleSignInTapped()
//                }, label: {
//                    //Text("AS")
//                    Image("AppleLogoBlack")
//                })
                
                
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .onOpenURL{ url in
            GIDSignIn.sharedInstance.handle(url)
        }
        .task{
            //self.store.send(.checkSignIn)
        }
        
        
        
    }
    
    func SignInWithAppleButtonPress() {
        let appleSignInProvider = ASAuthorizationAppleIDProvider()
        let appleSignInRequest = appleSignInProvider.createRequest()
        appleSignInRequest.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [appleSignInRequest])
        controller.delegate = .none
        controller.performRequests()
    }
}

#Preview {
    LoginView(store: Store(initialState: LoginFeature.State()) {
        LoginFeature()
    })
}
