//import Foundation
//import CoreLocation
//
//class LocationService: NSObject {
//    
//    var userLatitude: Double = 0
//    var userLongitude: Double = 0
//    var locationManager = CLLocationManager()
//    
//    override init() {
//        super.init()
//        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.requestLocation()
//    }
//}
//
//extension LocationService: CLLocationManagerDelegate {
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            self.userLatitude = location.coordinate.latitude
//            self.userLongitude = location.coordinate.longitude
//            print("[Updated Location] LocationService.userLatitude= \(self.userLatitude)")
//            print("[Updated Location] LocationService.userLongitude= \(self.userLongitude)")
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Failed to find user's location: \(error.localizedDescription)")
//    }
//}
