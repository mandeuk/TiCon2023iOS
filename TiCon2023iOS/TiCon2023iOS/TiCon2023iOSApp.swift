//
//  TiCon2023iOSApp.swift
//  TiCon2023iOS
//
//  Created by Inho Lee on 10/27/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct TiCon2023iOSApp: App {
    
    init() {
        // 런치스크린 딜레이
        Thread.sleep(forTimeInterval: 2)
        
        // 런치스크린 이미지 설정
        // Targets -> Info -> Launch Screen
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(store: Store(initialState: .init()){
                RootFeature()
            })
        }
    }
}
