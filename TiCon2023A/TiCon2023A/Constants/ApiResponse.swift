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

struct SignIn<T: Codable> : Codable{
    let statusCode: Int
    let message: String?
    let data: T?
}

struct Notice : Codable{
    let id: Int
    let title: String
    let createdAt: String
}

// MARK: - StakingList
struct StakingList: Codable{
    let id: Int
    let userId: String
    let parentUserId: String
    let amount: String
    let status: String
    let type: String
    let rate: String
    let referralRate: String
    let referralType: String
    let createdAt: String
    let approvedAt: String
    let rewardedAt: String
}
