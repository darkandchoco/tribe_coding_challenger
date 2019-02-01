//
//  VenueListView.swift
//  tribe_coding_challenger
//
//  Created by Richmond Ko on 01/02/2019.
//  Copyright © 2019 Richmond Ko. All rights reserved.
//

import Foundation

protocol VenueListView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setVenues(venues: [VenueData])
    func setEmptyVenues()
    func presentError(error: Error)
}
