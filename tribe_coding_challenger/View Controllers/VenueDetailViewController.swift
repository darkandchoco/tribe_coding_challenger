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
    var venue: VenueData?
    
    // MARK: - Stored (IBOutlet)
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var venueAddressLabel: UILabel!
    @IBOutlet weak var primaryCategoryLabel: UILabel!

    // MARK: - App View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setVenueDetail()
    }
    
    // MARK: - Instance
    private func setVenueDetail() {
        guard let venue = venue else { return }
        venueNameLabel.text = venue.name
        venueAddressLabel.text = venue.address
        primaryCategoryLabel.text = venue.primaryCategory
    }

}
