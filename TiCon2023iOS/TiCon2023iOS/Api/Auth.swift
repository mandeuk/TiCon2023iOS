//
//  Api.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

import Foundation
import ComposableArchitecture
import Alamofire

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



struct GetUserClient {
    var fetch: () async throws -> String
}

extension GetUserClient: DependencyKey {
    static let liveValue = Self(
        fetch: {
            
            let url = "https://api.corona-19.kr/korea/country/new/"
            let param = [
                "serviceKey": "zmgWZa6BOhkuU1XE7tYLRcyqpjeDfbKow"
            ]
            
            fetchData(completion: <#T##(Result<baseResponse<Notice>, NSError>) -> Void##(Result<baseResponse<Notice>, NSError>) -> Void##(_ result: Result<baseResponse<Notice>, NSError>) -> Void#>)
            
            async let result = AF.request("http://localhost:9000/api/auth/signIn",
                                          method: .post,
                                          parameters: param,
                                          encoder: JSONParameterEncoder.default).serializingData().response
            
            let response = await result
            
//            try await AF.request("url",
//                       method: .get,
//                       parameters: param,
//                       encoder: JSONParameterEncoder.default)
//            .responseData(completionHandler: {response in
//                
//            })
//            .response { response in
//            }
            
//            AF.request(url, method: .get, parameters: param)
//                .responseData(completionHandler: { response in
//                    switch response.result {
//                    case let .success(data):
//                        do {
//                            let decoder = JSONDecoder()
//                            //let result = try decoder.decode(CityCovidOverview.self, from: data)
//                            return ""
//                            //completionHandler(.success(result))
//                        } catch {
//                            //completionHandler(.failure(error))
//                        }
//                        
//                    case let .failure(error): 
//                        break
//                        //completionHandler(.failure(error))
//                    }
//                    
//                })
            
        }
    )
}

extension DependencyValues {
    var getUser: GetUserClient {
        get { self[GetUserClient.self] }
        set { self[GetUserClient.self] = newValue }
    }
}


func useEscaping(url: String, whenIfFailed: (), handler: @escaping (NSDictionary) -> Void) {
    
    let request = AF.request(url)
    
    request.responseJSON { (response) in
        switch response.result {
        case .success(let obj):
            guard let nsDic = obj as? NSDictionary else { return }
            handler(nsDic)
            
        case .failure(let e):
            // 통신 실패시
            print(e.localizedDescription)
            whenIfFailed
        }
    }
}



// 서버 통신을 통해 가져온 데이터 디코딩해주는 메서드
func fetchData(completion: @escaping (_ result: Result<baseResponse<Notice>, NSError>) -> Void) {
    let convertURL = "url"
    AF.request(convertURL, method: .get, encoding: JSONEncoding.default)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let randomInfo = try JSONDecoder().decode(baseResponse<Notice>.self, from: data)
                    completion(Result.success(randomInfo))
                } catch {
                    completion(Result.failure(decodingError(convertURL: convertURL, responseValue: value, underlying: error)))
                }
            case .failure(let error):
                completion(Result.failure(networkError(convertURL: convertURL, underlying: error)))
            }
        }
    }

// 네트워크 통신 실패 시 호출되는 메서드
fileprivate func networkError(convertURL: String, underlying: Error) -> NSError {
    return NSError(domain: "FetchRandomInfo", code: 1, userInfo: [
        "identifier": "FetchRandomInfo.networkError",
        "convertURL": convertURL,
        NSUnderlyingErrorKey: underlying,
    ])
}

// 디코딩 실패 시 호출되는 메서드
fileprivate func decodingError(convertURL: String, responseValue: Any, underlying: Error) -> NSError {
    return NSError(domain: "FetchRandomInfo", code: 2, userInfo: [
        "identifer": "FetchRandomInfo.decodingError",
        "convertURL": convertURL,
        "responseValue": responseValue,
        NSUnderlyingErrorKey: underlying,
    ])
}
