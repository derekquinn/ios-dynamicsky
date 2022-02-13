import Foundation
import CoreLocation

enum OpenWeatherService {

    static func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (T) -> Void) {
        guard let url = endpoint.url else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(result)
            } catch let error {
                print(error)
            }

        }.resume()
    }

}

enum Endpoint {
    case currentWeatherWithZip(zipCode: String)
    case currentWeatherWithCoordinates(coordinates: CLLocationCoordinate2D)
    case forecastWithCoordinates(coordinates: CLLocationCoordinate2D)

    var url: URL? {
        switch self {
        case .currentWeatherWithZip(let zipCode):
            var urlComponents = openWeatherCurrentConditionsBaseUrl()
            urlComponents.queryItems = [
                .init(name: "zip", value: zipCode),
                .init(name: "units", value: "imperial"),
                .init(name: "appid", value: Secrets.openWeatherAppId),
                .init(name: "countrycode", value: "US")
            ]
            return urlComponents.url
        case .currentWeatherWithCoordinates(let coordinates):
            var urlComponents = openWeatherCurrentConditionsBaseUrl()
                urlComponents.queryItems = [
                    .init(name: "lat", value: "\(coordinates.latitude)"),
                    .init(name: "lon", value: "\(coordinates.longitude)"),
                    .init(name: "units", value: "imperial"),
                    .init(name: "appid", value: Secrets.openWeatherAppId),
                    .init(name: "countrycode", value: "US")
                ]
            return urlComponents.url
        case .forecastWithCoordinates(let coordinates):
            var urlComponents = oneCallBaseUrl()
            urlComponents.queryItems = [
                .init(name: "lat", value: "\(coordinates.latitude)"),
                .init(name: "lon", value: "\(coordinates.longitude)"),
                .init(name: "units", value: "imperial"),
                .init(name: "appid", value: Secrets.openWeatherAppId),
                .init(name: "countrycode", value: "US")
            ]
            return urlComponents.url
        }
    }

    private func openWeatherCurrentConditionsBaseUrl() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        return urlComponents
    }

    private func oneCallBaseUrl() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/onecall"
        return urlComponents
    }
}
