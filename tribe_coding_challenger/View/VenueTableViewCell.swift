//
//  VenueTableViewCell.swift
//  tribe_coding_challenger
//
//  Created by Richmond Ko on 30/01/2019.
//  Copyright © 2019 Richmond Ko. All rights reserved.
//

import UIKit

class VenueTableViewCell: UITableViewCell {

    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    func configure(withVenue venue: VenueData) {
        venueNameLabel.text = venue.name
        distanceLabel.text = venue.distance
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
