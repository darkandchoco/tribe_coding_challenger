//
//  Category.swift
//  tribe_coding_challenger
//
//  Created by Richmond Ko on 04/02/2019.
//  Copyright © 2019 Richmond Ko. All rights reserved.
//

import Foundation

struct Category: Codable {
    let id: String?
    let name: String?
    let isPrimary: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isPrimary = "primary"
    }
}
