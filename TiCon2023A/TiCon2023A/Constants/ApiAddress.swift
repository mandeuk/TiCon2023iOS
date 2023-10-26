//
//  ApiAddress.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

enum ApiAddress {
    private static let serverAddress = "http://localhost:9000"
    
    enum Auth {
        private static let baseUrl = serverAddress + "/auth"
        
        public static let login = baseUrl + ""
    }
    
    enum Notice {
        private static let baseUrl = serverAddress + "/notice"
        
        public static let getNoticeList = baseUrl + "getNoticeList"
    }
    
    enum Sample {
        private static let baseUrl = serverAddress + "/sample"
        
        public static let login = baseUrl + ""
    }
}
