//
//  VenueService.swift
//  tribe_coding_challenger
//
//  Created by Richmond Ko on 30/01/2019.
//  Copyright © 2019 Richmond Ko. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

final class VenueService {
    private init() {}
    static let shared = VenueService()
    
    func getVenuesNearby(ll: String, limit: Int, completion: @escaping ([Venue]?, Error?) -> Void) {
        Alamofire.request(Router.getVenuesNearby(ll: ll, limit: limit)).responseDecodableObject { (response: DataResponse<VenuesSearchResponse>) in
            switch response.result {
            case .success(let venuesSearchResponse):
                completion(venuesSearchResponse.response?.venues, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
