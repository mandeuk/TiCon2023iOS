//
//  ApiResponse.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

// MARK: 기본 패킷 구조
struct baseResponse<T: Codable> : Codable{
    let statusCode: Int
    let message: String?
    let data: T?
}

struct UserInfo : Codable{
    let name: String
    let gender: String
    let birth: String
}

struct SignInWithAccount : Codable {
    let id: String
    let pw: String
}

struct SignInWithGoogle : Codable {
    let token: String
}
