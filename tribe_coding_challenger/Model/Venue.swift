//
//  Venue.swift
//  tribe_coding_challenger
//
//  Created by Richmond Ko on 30/01/2019.
//  Copyright © 2019 Richmond Ko. All rights reserved.
//

import Foundation
import CodableAlamofire

struct VenuesSearchResponse: Codable {
    let response: VenuesResponse?
}

struct VenuesResponse: Codable {
    let venues: [Venue]?
}

struct Venue: Codable {
    let id: String?
    let name: String?
    let location: Location?
}
