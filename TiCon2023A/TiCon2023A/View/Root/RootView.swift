//
//  RootView.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

struct RootView: View {
    let store: StoreOf<RootFeature>
    
    var body: some View {
        TCARouter(store) { screen in
            SwitchStore(screen) { screen in
                switch screen {
                case .login:
                    CaseLet(
                        /ScreenFeature.State.login,
                         action: ScreenFeature.Action.login,
                         then: LoginView.init
                    )
                    
                case .main:
                    CaseLet(
                        /ScreenFeature.State.main,
                         action: ScreenFeature.Action.main,
                         then: MainView.init
                    )
                    
                case .register:
                    CaseLet(
                        /ScreenFeature.State.register,
                         action: ScreenFeature.Action.register,
                         then: RegisterView.init
                    )
                    
                }
            }
        }
    }
}
