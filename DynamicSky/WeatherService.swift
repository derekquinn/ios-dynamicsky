import Foundation
import CoreLocation

public final class WeatherService: NSObject {
    
    private let locationManager = CLLocationManager()
    private var completionHandler: ((OpenSkyResponse)-> Void)?
    
    public override init(){
        super.init()
        locationManager.delegate = self
    }
    
    func loadWeatherData(_ completionHandler: @escaping ((OpenSkyResponse)-> Void)){
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D){
        guard let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&units=imperial&appid=\(Secrets.openSkyAppId)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        print("URL=== \(urlString)")
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            guard error == nil, let data = data else { return }
            
            if let response = try? JSONDecoder().decode(OpenSkyResponse.self, from: data) {
                print("[SUCCESS] RESPONSE RECEIVED \(response.daily.count)")
                self.completionHandler?(OpenSkyResponse(response: response))
            }
        }).resume()
    }
}

//extension WeatherService: CLLocationManagerDelegate {
//    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else { return }
//        makeDataRequest(forCoordinates: location.coordinate)
//    }
//}
//
//public func locationManager(_ main: CLLocationManager, didFailWithError error: Error){
//    print("[Error] locationManager \(error.localizedDescription)")
//}

extension WeatherService: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        makeDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
