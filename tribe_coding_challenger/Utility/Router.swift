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
    static let baseURLString = "https://api.foursquare.com/v2"
    static let CLIENT_ID = "0PYC02LDVKSN1OYNHWJPDLL44TLMKWBDRGT4Z23TYEBT0TXA"
    static let CLIENT_SECRET = "0YRCME3RJAB5TZKP3T5SMEVATONIQLH1EJVVY2HL3FEYMBIO"
    static let API_VERSION = "20180323"
    
    case getVenuesNearby(ll: String, limit: Int)
    
    private var method: HTTPMethod {
        switch self {
        case .getVenuesNearby: return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getVenuesNearby:
            return "/venues/search"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        switch self {
        case .getVenuesNearby(let ll, let limit):
            let parameters: [String: Any] = [
                "client_id": Router.CLIENT_ID,
                "client_secret": Router.CLIENT_SECRET,
                "ll": ll,
                "limit": limit,
                "v": Router.API_VERSION
            ]
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
