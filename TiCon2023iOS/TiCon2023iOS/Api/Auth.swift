//
//  Api.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import Foundation
import ComposableArchitecture
import Alamofire


// SAMPLE
struct LoginClient {
    var fetch: (Int) async throws -> String
}

extension LoginClient: DependencyKey {
    static let liveValue = Self(
        fetch: { number in
            let (data, _) = try await URLSession.shared
                .data(from: URL(string: "http://numbersapi.com/\(number)")!
                )
            return String(decoding: data, as: UTF8.self)
        }
    )
}

extension DependencyValues {
    var login: LoginClient {
        get { self[LoginClient.self] }
        set { self[LoginClient.self] = newValue }
    }
}



// Get User
struct GetUserClient {
    var fetch: () async throws -> UserInfo
}

extension GetUserClient: DependencyKey {
    static let liveValue = Self(
        fetch: {
            let param: [String:String] = [:
                //"idToken": idToken
            ]
            
            async let result = AF.request(ApiAddress.Auth.getUser,
                                          method: .get,
                                          parameters: param,
                                          encoder: JSONParameterEncoder.default).serializingData().response
            
            let response = await result
            
            switch response.result {
            case .success(_):
                debugPrint("response success")
                let json = try? JSONDecoder().decode(baseResponse<UserInfo>.self, from: response.data!)
                
                debugPrint(String(json?.statusCode ?? 0))
                switch json?.statusCode {
                case 200:
                    debugPrint("200 성공 already Create ID")
                    debugPrint("\(String(describing: json?.data))")
                    return (json?.data) ?? UserInfo(name: "err", gender: "err", birth: "err")
                    
                case .none:
                    debugPrint("statusCode: none")
                    break
                    
                case .some(_):
                    debugPrint("statusCode: \(json?.statusCode ?? 0), msg: \(json?.message  ?? "err")")
                    break
                }
                break
                
            case .failure(_):
                //실패했을 때
                debugPrint("response failure")
                break
            }
            
            return UserInfo(name: "err", gender: "err", birth: "err")
        }
    )
}

extension DependencyValues {
    var getUser: GetUserClient {
        get { self[GetUserClient.self] }
        set { self[GetUserClient.self] = newValue }
    }
}



// Sign in with Google
struct SignInWithGoogleClient {
    var fetch: (String) async throws -> Int //UserInfo
}

extension SignInWithGoogleClient: DependencyKey {
    static let liveValue = Self(
        fetch: { idToken in
            let param = [
                "idToken": idToken
            ]
            
            debugPrint("SignInWithGoogle param: \(param)")
            
            async let result = AF.request(ApiAddress.Auth.signInWithGoogle,
                                          method: .post,
                                          parameters: param,
                                          encoder: JSONParameterEncoder.default).serializingData().response
            
            let response = await result
            
            switch response.result {
            case .success(_):
                debugPrint("response success")
                let json = try? JSONDecoder().decode(baseResponse<UserInfo>.self, from: response.data!)
                
                return json?.statusCode ?? 0
                
//                debugPrint(String(json?.statusCode ?? 0))
//                switch json?.statusCode {
//                case 200:
//                    debugPrint("200 성공 already Create ID")
//                    debugPrint("\(String(describing: json?.data))")
//                    return (json?.data) ?? UserInfo(name: "err", gender: "err", birth: "err")
//                    
//                case 401:
//                    debugPrint("401 인증실패")
//                    break
//                case 403:
//                    debugPrint("403 No member data you have to Create ID")
//                    break
//                case 500:
//                    debugPrint("500 서버오류")
//                    break
//                    
//                case .none:
//                    debugPrint("statusCode : none - 개발자에게 문의해 주세요.")
//                    break
//                case .some(_):
//                    debugPrint("전화번호 및 국가코드를 다시 확인해 주세요.")
//                    break
//                }
//                break
                
            case .failure(_):
                //실패했을 때
                debugPrint("response failure")
                break
            }
            
            return 0//UserInfo(name: "err", gender: "err", birth: "err")
        }
    )
}

extension DependencyValues {
    var signInWithGoogle: SignInWithGoogleClient {
        get { self[SignInWithGoogleClient.self] }
        set { self[SignInWithGoogleClient.self] = newValue }
    }
}



// Register
struct RegisterUserClient {
    var fetch: (_ platform: String, _ idToken: String, _ name: String, _ gender: String, _ birth: String) async throws -> Int //UserInfo
}

extension RegisterUserClient: DependencyKey {
    static let liveValue = Self(
        fetch: { (platform, idToken, name, gender, birth ) in
            let param = [
                "platform": platform,
                "idToken": idToken,
                "name": name,
                "gender": gender,
                "birth": birth
            ]
            
            async let result = AF.request(ApiAddress.Auth.registerUser,//"http://localhost:9001/api/auth/registerUser",
                                          method: .post,
                                          parameters: param,
                                          encoder: JSONParameterEncoder.default).serializingData().response
            
            let response = await result
            
            switch response.result {
            case .success(_):
                debugPrint("response success")
                let json = try? JSONDecoder().decode(baseResponse<UserInfo>.self, from: response.data!)
                
                return json?.statusCode ?? 0
                
                //                debugPrint(String(json?.statusCode ?? 0))
                //                switch json?.statusCode {
                //                case 200:
                //                    debugPrint("200 성공 already Create ID")
                //                    debugPrint("\(String(describing: json?.data))")
                //                    return (json?.data) ?? UserInfo(name: "err", gender: "err", birth: "err")
                //
                //                case 401:
                //                    debugPrint("401 인증실패")
                //                    break
                //                case 403:
                //                    debugPrint("403 No member data you have to Create ID")
                //                    break
                //                case 500:
                //                    debugPrint("500 서버오류")
                //                    break
                //
                //                case .none:
                //                    debugPrint("statusCode : none - 개발자에게 문의해 주세요.")
                //                    break
                //                case .some(_):
                //                    debugPrint("전화번호 및 국가코드를 다시 확인해 주세요.")
                //                    break
                //                }
                //                break
                
            case .failure(_):
                //실패했을 때
                debugPrint("response failure")
                break
            }
            
            return 0//UserInfo(name: "err", gender: "err", birth: "err")
        }
    )
}

extension DependencyValues {
    var registerUser: RegisterUserClient {
        get { self[RegisterUserClient.self] }
        set { self[RegisterUserClient.self] = newValue }
    }
}
