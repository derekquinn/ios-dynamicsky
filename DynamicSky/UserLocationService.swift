import Foundation
import CoreLocation

final class UserLocationService: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    static var coordinates: CLLocationCoordinate2D?

    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        UserLocationService.coordinates = location.coordinate
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("[LOCATION ERROR] \(error)")
    }
}
