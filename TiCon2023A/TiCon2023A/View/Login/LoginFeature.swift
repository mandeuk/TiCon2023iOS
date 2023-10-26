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
    @AppStorage("test") private var test: String = ""
    @AppStorage("currentLoginPlatform") private var currentLoginPlatform: String = ""
    
    struct State: Equatable {
        var id: String = ""
        var password: String = ""
        var emailFieldIsFocused: Bool = false
        var tryAutoLogin: Bool = false
        var isShowUnauthSheet: Bool = false
    }
    
    enum Action {
        case idChange(String)
        case pwChange(String)
        
        case trySignIn
        case tryAutoSignIn
        
        case checkSignIn
        case failCheckSignIn
        
        // SNS SignIn
        case googleSignIn
        case appleSignIn
        case signInSuccess(String)
        case signInFailure
        
        // Navigation actions
        case pushMainView
        case pushRegisterView
        case presentUnauthSheet
        case pushFindPasswordView
    }
    
    var body: some ReducerOf<Self>{
        Reduce<State, Action> { state, action in
            switch action {
            case let .idChange(text):
                state.id = text
                self.test = text
                break
                
            case let .pwChange(text):
                state.password = text
                break
                
            case .trySignIn:
                return .run { [state] send in
                    let param: [String: String] = [
                        "account": state.id,
                        "password": state.password,
                    ]
                    //debugPrint("param => \(param)")
                    
                    async let result = AF.request("http://localhost:9000/api/auth/signIn",
                                                  method: .post,
                                                  parameters: param,
                                                  encoder: JSONParameterEncoder.default).serializingData().response
                    
                    let response = await result
                    
                    switch response.result {
                    case .success(_):
                        debugPrint("성공")
                        let json = try? JSONDecoder().decode(baseResponse<Int>.self, from: response.data!)
                        
                        debugPrint(String(json?.statusCode ?? 0))
                        switch json?.statusCode {
                        case 200:
                            debugPrint("200 성공 already Create ID")
                            debugPrint("\(String(describing: json?.data))")
                            break
                        case 401:
                            debugPrint("401 인증실패")
                            break
                        case 403:
                            debugPrint("403 No member data you have to Create ID")
                            break
                        case 500:
                            debugPrint("500 서버오류")
                            break
                        case .none:
                            debugPrint("statusCode : none - 개발자에게 문의해 주세요.")
                            break
                        case .some(_):
                            debugPrint("전화번호 및 국가코드를 다시 확인해 주세요.")
                            break
                        }
                        
                    case .failure(_):
                        //실패했을 때
                        
                        break
                    }
                    return
                }
                
            case .checkSignIn:
                state.tryAutoLogin = true
                
                let platform = LoginPlatform(rawValue: currentLoginPlatform)
                
                
                switch platform {
                case .email:
                    // 자동 로그인은 세션 쿠키로
                    state.tryAutoLogin = false
                    return .send(.trySignIn)
                case .apple:
                    break
                case .google:
                    var success: Bool = false
                    GIDSignIn.sharedInstance.restorePreviousSignIn{ user, error in
                        if ((user) != nil) {
                            debugPrint("Success to restore \(String(describing: user?.accessToken))")
                            success = true
                        } else {
                            debugPrint("Failed to restore \(String(describing: error))")
                            success = false
                        }
                    }
                    if (success) {
                        state.tryAutoLogin = false
                        return .send(.googleSignIn)
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
//                currentLoginPlatform.
//                UserDefaults.standard.removeObject(forKey: UDKey.currentLoginPlatform)
//                UserDefaults.standard.removeObject(forKey: UDKey.id)
//                UserDefaults.standard.removeObject(forKey: UDKey.pw)
//                UserDefaults.standard.removeObject(forKey: UDKey.token)
                break
                
            case .googleSignIn:
                debugPrint("Reducer .googleSignIn end")
                break
                
            case .appleSignIn:
                
                break
                
            case .signInSuccess(let token):
                debugPrint("Reducer .signInSuccess : \(token)")
                break
                
            case .signInFailure:
                debugPrint("Reducer .signInFailure")
                break
                
            case .presentUnauthSheet:
                state.isShowUnauthSheet = true
                break
                
            default:
                break
            }
            return .none
        }
    }
}
