import Foundation

public class WeatherViewModel: ObservableObject {
    
    @Published var current = Current()
    @Published var daily = [Daily]()
    @Published var openWeatherSearchResponse = OpenWeatherSearchResponse()
    
    public let weatherService: WeatherFromUserLocationService
    
    public init(weatherService: WeatherFromUserLocationService){
        self.weatherService = weatherService
    }
    
    public func refreshWeatherDataFromCurrentLocation(){
        weatherService.retrieveUserLocation { weather in
            DispatchQueue.main.async {
                self.current = weather.current
                self.daily = weather.daily
            }
        }
    }
    
    public func retrieveSearchResults(zipCode: String){
        DispatchQueue.main.async{
            WeatherFromZipSearchService.retrieveSearchResultsFromUserEnteredZip(zipCode: zipCode) { results in
                self.openWeatherSearchResponse = results
            }
        }
    }
}
