//
//  VenueDetailViewController.swift
//  tribe_coding_challenger
//
//  Created by Richmond Ko on 30/01/2019.
//  Copyright © 2019 Richmond Ko. All rights reserved.
//

import UIKit

class VenueDetailViewController: UIViewController {

    // MARK: - Stored
    var venue: Venue?
    
    // MARK: - Stored (IBOutlet)
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var venueAddressLabel: UILabel!
    
    // MARK: - App View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setVenueDetail()
    }
    
    // MARK: - Instance
    private func setVenueDetail() {
        guard let venue = venue else { return }
        venueNameLabel.text = venue.name
        
        guard let formattedAddress = venue.location?.formattedAddress else { return }
        venueAddressLabel.text = getCompleteAddressString(addressArray: formattedAddress)
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
