//
//  VenuesListViewController.swift
//  tribe_coding_challenger
//
//  Created by Richmond Ko on 30/01/2019.
//  Copyright © 2019 Richmond Ko. All rights reserved.
//

import UIKit
import CoreLocation

class VenuesListViewController: UIViewController {

    // MARK: - Stored
    private let refreshControl = UIRefreshControl()
    private let venuePresenter = VenuePresenter(venueService: VenueService.shared)
    private var locationManager: CLLocationManager?
    private var venuesToDisplay: [VenueData] = []
    private var selectedVenue: VenueData?
    
    // MARK: - Stored (IBOutlet)
    @IBOutlet weak var placesTableView: UITableView!
    
    // MARK: - App View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureLocationManager()
        configureRefreshControl()
        venuePresenter.attachView(view: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.showVenueDetail.rawValue {
            let destination = segue.destination as! VenueDetailViewController
            destination.venue = selectedVenue
        }
    }
    
    // MARK: - Instance
    private func configureTableView() {
        placesTableView.delegate = self
        placesTableView.dataSource = self
        placesTableView.tableFooterView = UIView()
        placesTableView.refreshControl = refreshControl
    }
    
    private func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(self.updateCurrentLocation), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching venues nearby...")
    }
    
    @objc private func updateCurrentLocation() {
        locationManager!.requestLocation()
    }
    
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            refreshControl.beginRefreshing()
            locationManager!.requestLocation()
        }
    }
}

extension VenuesListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venuesToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.venueCell.rawValue, for: indexPath) as! VenueTableViewCell
        cell.configure(withVenue: venuesToDisplay[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedVenue = venuesToDisplay[indexPath.row]
        performSegue(withIdentifier: SegueIdentifier.showVenueDetail.rawValue, sender: self)
    }
}

extension VenuesListViewController: CLLocationManagerDelegate {
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
        guard locations.count > 0, let location = locations.first else {
            return
        }
        
        let llString = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        venuePresenter.searchVenuesNearby(ll: llString, limit: 20)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        refreshControl.endRefreshing()
        presentErrorAlertController(error: error)
    }
}

extension VenuesListViewController: VenueListView {
    func setEmptyVenues() {
        
    }
    
    func presentError(error: Error) {
        presentErrorAlertController(error: error)
    }
    
    func startLoading() {
        refreshControl.beginRefreshing()
    }
    
    func finishLoading() {
        refreshControl.endRefreshing()
    }
    
    func setVenues(venues: [VenueData]) {
        venuesToDisplay = venues
        placesTableView.reloadData()
    }
}
