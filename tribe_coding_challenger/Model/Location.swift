//
//  Location.swift
//  tribe_coding_challenger
//
//  Created by Richmond Ko on 30/01/2019.
//  Copyright © 2019 Richmond Ko. All rights reserved.
//

import Foundation
import CodableAlamofire

struct Location: Codable {
    let distance: Double?
    let formattedAddress: [String]?
}
