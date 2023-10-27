//
//  SignInAppleController.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import ComposableArchitecture
import AuthenticationServices

class SignInAppleController: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    let store: StoreOf<LoginFeature>
    
    init(store: StoreOf<LoginFeature>) {
        self.store = store
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return .init()
    }
    
    func appleSignInTapped() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = []//[.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension SignInAppleController {
    // 로그인 성공
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let userIdentifier = appleIDCredential.user //userIdentifier
            let userName = appleIDCredential.fullName //fullName
            let userEmail = appleIDCredential.email //email
            
            debugPrint("userIdentifier: \(userIdentifier)")
            debugPrint("userName: \(String(describing: userName))")
            debugPrint("userEmail: \(userEmail ?? "ERROR")")
            store.send(.signInSuccess(userIdentifier))
        }
    }
    
    // 로그인 실패
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        store.send(.signInFailure)
    }
    
}
