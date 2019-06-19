//
//  ViewController.swift
//  GetLocation
// Sand box for get Location date
//
//
//  Created by SubaruShiozaki on 2019-06-16.
//  Copyright © 2019 Kazuya Takahashi. All rights reserved.
//

import UIKit
// 1. import CoreLocation FW
import CoreLocation

class ViewController: UIViewController {
  
  // 2. To declare locationManager instance as a class member
  var locationManager: CLLocationManager!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLocationManager()
  }
  
  
  // 2-1. Set upper for locationManager
  func setupLocationManager() {
    locationManager = CLLocationManager()
    
    // 3. To request grant for get location
    // 3-1. To request the grant when success to create location manager
    guard let locationManager = locationManager else {return}
    locationManager.requestWhenInUseAuthorization()
    
    // 4. Setting Manager when success to get grant for location
    // 4-1. To get grant status from "CLLOcationManager" class
    let status = CLLocationManager.authorizationStatus()
    // Validation status
    if status == .authorizedWhenInUse {
      // 5-1. To set delegate when status is authorizedWhenInUse
      locationManager.delegate = self
      
      // unit is meter
      locationManager.distanceFilter = 10
      locationManager.startUpdatingLocation()
    }
  }
}

// 5. To extend ViewController by CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations.first
    let latitude = location?.coordinate.latitude
    let longitude = location?.coordinate.longitude

    print("latitude: \(latitude!) \nlogntitude \(longitude!)")
  }
}

