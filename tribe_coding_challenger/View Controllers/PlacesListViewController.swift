//
//  PlacesListViewController.swift
//  tribe_coding_challenger
//
//  Created by Richmond Ko on 30/01/2019.
//  Copyright © 2019 Richmond Ko. All rights reserved.
//

import UIKit
import CoreLocation

class PlacesListViewController: UIViewController {

    // MARK: - Stored
    private var locationManager: CLLocationManager?
    
    // MARK: - Stored (IBOutlet)
    @IBOutlet weak var placesTableView: UITableView!
    
    // MARK: - App View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureLocationManager()
    }
    
    // MARK: - Instance
    private func configureTableView() {
        placesTableView.delegate = self
        placesTableView.dataSource = self
        placesTableView.tableFooterView = UIView()
    }
    
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager!.requestLocation()
        }
    }
}

extension PlacesListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.venueCell.rawValue, for: indexPath) as! VenueTableViewCell
        return cell
    }
}

extension PlacesListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard let locationManager = locationManager else { return }
        switch status {
        case .authorizedAlways:
            locationManager.requestLocation()
        case .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied:
            locationManager.requestWhenInUseAuthorization()
            presentDismissableAlertController(title: "Error", message: "You have denied location access for this app, please enable this on your settings")
        case .notDetermined:
            break
        case .restricted:
            presentDismissableAlertController(title: "Error", message: "Location features are restricted on this device.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.count > 0 else {
            return
        }
        
        print(locations.first)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        presentErrorAlertController(error: error)
    }
}
