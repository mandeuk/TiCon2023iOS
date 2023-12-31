//
//  ApiAddress.swift
//  TiCon2023A
//
//  Created by Inho Lee on 10/26/23.
//

enum ApiAddress {
    private static let serverAddress = "http://192.168.0.96:9001/api"
    
    enum Auth {
        private static let baseUrl = serverAddress + "/auth"
        
        public static let login = baseUrl + "/"
        public static let logout = baseUrl + "/logout"
        public static let getUser = baseUrl + "/getUser"
        public static let registerUser = baseUrl + "/registerUser"
        public static let signInWithGoogle = baseUrl + "/signInWithGoogle"
    }
    
    enum Notice {
        private static let baseUrl = serverAddress + "/notice"
        
        public static let getNoticeList = baseUrl + "/getNoticeList"
    }
    
    enum Sample {
        private static let baseUrl = serverAddress + "/sample"
        
        public static let login = baseUrl + "/"
    }
}
