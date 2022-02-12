import Foundation
import Firebase

class WeatherFromZipSearchService {

    static func retrieveSearchResultsFromUserEnteredZip(zipCode: String, completion: @escaping (OpenWeatherSearchResponse) -> (Void) ){
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?zip=\(zipCode)&&units=imperial&appid=\(Secrets.openWeatherAppId)&countrycode=US".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
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

            DispatchQueue.main.async{

                do {
                    let response = try JSONDecoder().decode(OpenWeatherSearchResponse.self, from: data)
                    Crashlytics.crashlytics().log("[OPEN WEATHER REQUEST SUCCESS] RESPONSE RECEIVED \(response.name)")
                    print("City===\(response.name)")
                    completion(response)
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
            }
        }).resume()
    }
}

