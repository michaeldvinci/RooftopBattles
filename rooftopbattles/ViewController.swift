//
//  ViewController.swift
//  rooftopbattles
//
//  Created by Mike Vinci on 10/22/22.
//

import UIKit
import MapKit
import CoreLocation

var seenError : Bool = false
var locationFixAchieved : Bool = false
var locationStatus : NSString = "Not Started"

var locMan: CLLocationManager!
class ViewController: UIViewController, CLLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let locMan = CLLocationManager()
        initLocationManager()
        if CLLocationManager.locationServicesEnabled() {
            locMan.delegate = self
            print("here")
            locMan.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locMan.startUpdatingLocation()
        }
        
//        locMan.startUpdatingLocation()
    }
    
    func initLocationManager() {
     seenError = false
     locationFixAchieved = false
      locMan = CLLocationManager()
     locMan.delegate = self
     locMan.desiredAccuracy = kCLLocationAccuracyBest
        print("here2")
      locMan.requestAlwaysAuthorization()
  }

    private func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
      locMan.stopUpdatingLocation()
        if ((error) != nil) {
          if (seenError == false) {
              seenError = true
              print(error as Any)
          }
      }
  }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
      if (locationFixAchieved == false) {
          locationFixAchieved = true
          var locationArray = locations as NSArray
          var locationObj = locationArray.lastObject as! CLLocation
          var coord = locationObj.coordinate

          print(coord.latitude)
          print(coord.longitude)
      }
  }

   func locationManager(manager: CLLocationManager!,
      didChangeAuthorizationStatus status: CLAuthorizationStatus) {
          var shouldIAllow = false

          switch status {
          case CLAuthorizationStatus.restricted:
              locationStatus = "Restricted Access to location"
          case CLAuthorizationStatus.denied:
              locationStatus = "User denied access to location"
          case CLAuthorizationStatus.notDetermined:
              locationStatus = "Status not determined"
          default:
              locationStatus = "Allowed to location Access"
              shouldIAllow = true
          }
          if (shouldIAllow == true) {
              NSLog("Location to Allowed")
              // Start location services
              rooftopbattles.locMan.startUpdatingLocation()
          } else {
              NSLog("Denied access: \(locationStatus)")
          }
  }
    
//    func askForPerms() {
//        let locMan = CLLocationManager()
//        switch locMan.authorizationStatus {
//        case .notDetermined:
//            locMan.requestAlwaysAuthorization()
//            locMan.requestWhenInUseAuthorization()
//            return
//        case .denied, .restricted:
//            let alert = UIAlertController(title: "Location Services are disabled", message: "Please enable Location Services in your Settings", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alert.addAction(okAction)
//            present(alert, animated: true, completion: nil)
//            return
//        case .authorizedAlways, .authorizedWhenInUse:
//            break
//        @unknown default:
//            return print("unkown")
//        }
//    }
}



