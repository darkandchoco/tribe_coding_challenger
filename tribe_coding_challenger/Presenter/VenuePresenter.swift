//
//  VenuePresenter.swift
//  tribe_coding_challenger
//
//  Created by Richmond Ko on 01/02/2019.
//  Copyright © 2019 Richmond Ko. All rights reserved.
//

import Foundation

class VenuePresenter {
    private let venueService: VenueService
    weak private var venueListView: VenueListView?
    
    init(venueService: VenueService) {
        self.venueService = venueService
    }
    
    func attachView(view: VenueListView) {
        venueListView = view
    }
    
    func detachView() {
        venueListView = nil
    }
    
    func searchVenuesNearby(ll: String, limit: Int) {
        self.venueListView?.startLoading()
        VenueService.shared.getVenuesNearby(ll: ll, limit: limit) { [weak self] (venues, error) in
            guard let self = self else { return }
            self.venueListView?.finishLoading()
            if let venues = venues {
                let sortedVenues = venues.sorted(by: { (lvenue, rvenue) -> Bool in
                    guard let lvenueDistance = lvenue.location?.distance,
                        let rvenueDistance = rvenue.location?.distance else {
                            return false
                    }
                    return lvenueDistance < rvenueDistance
                })
                let mappedVenues = sortedVenues.map({ (venue) -> VenueData in
                    let address = self.getCompleteAddressString(addressArray: venue.location?.formattedAddress ?? [])
                    return VenueData(name: venue.name ?? "", address: address, distance: "\(venue.location?.distance ?? 0)m")
                })
                self.venueListView?.setVenues(venues: mappedVenues)
            } else if let error = error {
                self.venueListView?.presentError(error: error)
            }
        }
    }
    
    private func getCompleteAddressString(addressArray: [String]) -> String {
        var completeAddress = ""
        for (index, addressString) in addressArray.enumerated() {
            completeAddress += addressString
            if index != addressArray.count - 1 {
                completeAddress += ", "
            }
        }
        return completeAddress
    }
}
