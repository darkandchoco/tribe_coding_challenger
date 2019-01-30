//
//  Router.swift
//  tribe_coding_challenger
//
//  Created by Richmond Ko on 30/01/2019.
//  Copyright © 2019 Richmond Ko. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    static let baseURLString = "http://testbed.website/Toyota/ServiceBooking/public/api"//"http://qualityassurance.review/Toyota/ServiceBooking/public/api"
    
    case authenticate(email: String, password: String)
    
    private var method: HTTPMethod {
        switch self {
        case .authenticate: return .post
        }
    }
    
    private var path: String {
        switch self {
        case .authenticate:
            return "/login"
        
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
//        if let token = KeychainSwift().get(Constant.tokenKey.rawValue), token.count != 0 {
//            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }
        
        switch self {
        case .authenticate(let email, let password):
            let parameters: [String: Any] = [
                "email": email,
                "password": password,
                "device_name": UIDevice.current.name,
                "platform": "native",
                "device_type": "ios",
                "device_id": UIDevice.current.identifierForVendor!.uuidString,
                "device_token": "something"
            ]
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
