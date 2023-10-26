//
//  TiCon2023AApp.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct TiCon2023AApp: App {
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
