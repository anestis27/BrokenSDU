//
//  BeaconTestController.swift
//  BrokenSDU
//
//  Created by Jonas Boserup on 06/11/2018.
//  Copyright © 2018 SDU. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconTestController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialze the loocation manager
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        view.backgroundColor = UIColor.white
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Only scan for beacons when app is authorized for location permission
        if(status == .authorizedWhenInUse || status == .authorizedAlways) {
            // Only scan when monitoring is available
            if(CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) &&
                CLLocationManager.isRangingAvailable()) {
                scanForBeacons()
            } else {
                print("CLLocationManager monitoring is unavailable")
            }
        } else {
            print("Location is not authorized")
        }
    }
    
    func scanForBeacons() {
        // Values: https://developer.kontakt.io/mobile/ios/detecting/
        let uuid = UUID(uuidString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "Beacon region 1")
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if beacons.count > 0 {
            print("\(beacons.count) beacons nearby")
            
            for beacon in beacons {
                print(beacon.debugDescription)
            }
        } else {
            print("No beacons nearby")
        }
    }
    
}

