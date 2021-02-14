import Foundation
import CoreLocation
import FirebaseCrashlytics

public final class WeatherFromUserLocationService: NSObject {
    
    private let locationManager = CLLocationManager()
    private var completionHandler: ((OpenWeatherResponse)-> Void)?
    
    public override init(){
        super.init()
        locationManager.delegate = self
    }
    
    func retrieveUserLocation(_ completionHandler: @escaping ((OpenWeatherResponse)-> Void)){
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    private func requestWeatherWithUserCoordinates(forCoordinates coordinates: CLLocationCoordinate2D){
        guard let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&units=imperial&appid=\(Secrets.openWeatherAppId)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            Crashlytics.crashlytics().log("[OPEN WEATHER REQUEST ERROR] urlString exception")
            return
        }
        
        guard let url = URL(string: urlString) else{
            Crashlytics.crashlytics().log("[ERROR OPEN WEATHER REQUEST] URL =\(urlString)")
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            guard error == nil, let data = data else {
                Crashlytics.crashlytics().log("[ERROR OPEN WEATHER REQUEST] URLSession Error =\(error.debugDescription)")
                return
            }
            do {
                let response = try JSONDecoder().decode(OpenWeatherResponse.self, from: data)
                Crashlytics.crashlytics().log("[OPEN WEATHER REQUEST SUCCESS] RESPONSE RECEIVED \(response.daily.count)")
                self.completionHandler?(OpenWeatherResponse(response: response))
            } catch let DecodingError.dataCorrupted(context) {
                Crashlytics.crashlytics().log("[ERROR JSONDecoder()] .dataCorrupted context = \(context)")
            } catch let DecodingError.keyNotFound(key, context) {
                Crashlytics.crashlytics().log("[ERROR JSONDecoder()] .keyNotFound key= \(key) context = \(context)")
            } catch let DecodingError.valueNotFound(value, context) {
                Crashlytics.crashlytics().log("[ERROR JSONDecoder()] .valueNotFound value= \(value) context = \(context)")
            } catch let DecodingError.typeMismatch(type, context)  {
                Crashlytics.crashlytics().log("[ERROR JSONDecoder()] .typeMismatch type= \(type) context = \(context)")
            } catch {
                Crashlytics.crashlytics().log("[ERROR JSONDecoder()] error= \(error)")
            }
        }).resume()
    }
}

extension WeatherFromUserLocationService: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        requestWeatherWithUserCoordinates(forCoordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        let err = CLError.Code(rawValue: (error as NSError).code)!
        switch err {
        case .locationUnknown:
            Crashlytics.crashlytics().log("[ERROR LOCATION MANAGER] User Location .locationUnknown Error = \(err)")
        case .denied:
            Crashlytics.crashlytics().log("[ERROR LOCATION MANAGER] User Location .denied Error = \(err)")
        case .promptDeclined:
            Crashlytics.crashlytics().log("[ERROR LOCATION MANAGER] User Location .promptDeclined Error = \(err)")
        case .deferredCanceled:
            Crashlytics.crashlytics().log("[ERROR LOCATION MANAGER] User Location .deferredCancelled Error = \(err)")
        case .deferredAccuracyTooLow:
            Crashlytics.crashlytics().log("[ERROR LOCATION MANAGER] User Location .deferredAccuracyTooLow Error = \(err)")
        case .deferredNotUpdatingLocation:
            Crashlytics.crashlytics().log("[ERROR LOCATION MANAGER] User Location .deferredNotUpdatingLocation Error = \(err)")
        default:
            Crashlytics.crashlytics().log("[ERROR LOCATION MANAGER] User Location .default (Unknown) Error = \(error)")
        }
        
    }
}
