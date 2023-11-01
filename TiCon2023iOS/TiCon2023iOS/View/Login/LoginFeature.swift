//
//  LoginFeature.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import ComposableArchitecture
import SwiftUI
import Alamofire
import GoogleSignIn
import AuthenticationServices

struct LoginFeature: Reducer {
    @AppStorage("didLogout") private var didLogout: Bool = false
    @AppStorage("currentLoginPlatform") private var currentLoginPlatform: String = ""
    @Dependency(\.getUser) var getUser
    @Dependency(\.signInWithGoogle) var signInWithGoogle

    struct State: Equatable {
        var id: String = ""
        var password: String = ""
        var emailFieldIsFocused: Bool = false
        var tryAutoLogin: Bool = false
        var isShowUnauthSheet: Bool = false
    }
    
    enum Action {
        case checkSignIn
        case failCheckSignIn
        
        case getUser
        
        // SNS SignIn
        case googleSignIn(String)
        case appleSignIn(String)
        case signInSuccess
        case signInFailure
        
        // Navigation actions
        case pushMainView
        case pushRegisterView(String)
    }
    
    var body: some ReducerOf<Self>{
        Reduce<State, Action> { state, action in
            switch action {
            case .checkSignIn:
                state.tryAutoLogin = true
                
                let platform = LoginPlatform(rawValue: currentLoginPlatform)
                
                
                switch platform {
                case .email:
                    // 자동 로그인은 세션 쿠키로
                    state.tryAutoLogin = false
                    return .send(.getUser)
                case .apple:
                    break
                case .google:
                    var success: Bool = false
                    var idToken: String = ""
                    GIDSignIn.sharedInstance.restorePreviousSignIn{ user, error in
                        if ((user) != nil) {
                            debugPrint("Success to restore \(String(describing: user?.accessToken))")
                            success = true
                            idToken = user?.idToken?.tokenString ?? ""
                        } else {
                            debugPrint("Failed to restore \(String(describing: error))")
                            success = false
                        }
                    }
                    if (success && !idToken.isEmpty) {
                        state.tryAutoLogin = false
                        return .send(.googleSignIn(idToken))
                    }
                    break
                case .kakao:
                    break
                case .none:
                    break
                }
                state.tryAutoLogin = false
                return .send(.failCheckSignIn)
                
            case .failCheckSignIn:
                break
                
            case .googleSignIn(let token):
                didLogout = false
                return .run { send in
                    let statusCode = try await signInWithGoogle.fetch(token)
                    
                    switch(statusCode){
                    case 200:
                        await send(.signInSuccess)
                        //홈 화면으로
                        break
                    case 403:
                        debugPrint("403")
                        //회원가입 화면으로
                        await send(.pushRegisterView(token))
                        break
                    default:
                        await send(.signInFailure)
                        //실패처리
                        break
                    }
                }
                
            case .appleSignIn(let token):
                didLogout = false
                debugPrint("Try Apple sign in: \(token)")
                break
                
            case .signInSuccess:
                debugPrint("Reducer .signInSuccess")
                return .send(.pushMainView)
                
            case .signInFailure:
                debugPrint("Reducer .signInFailure")
                //실패처리 구현해야함
                break
                
            case .getUser:
                if (didLogout == false){
                    return .run { send in
                        let response = try await getUser.fetch()
                        if (response.statusCode == 200) {
                            await send(.pushMainView)
                        }
                    }
                } else {
                    debugPrint("didLogout: \(didLogout)")
                }
                break
                
            default:
                break
            }
            return .none
        }
    }
}
