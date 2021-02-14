import Foundation

public class WeatherViewModel: ObservableObject {
    
    @Published var current = Current()
    @Published var daily = [Daily]()
    
    public let weatherService: WeatherFromUserLocationService
    
    public init(weatherService: WeatherFromUserLocationService){
        self.weatherService = weatherService
    }
    
    public func refreshWeatherData(){
        weatherService.retrieveUserLocation { weather in
            DispatchQueue.main.async {
                self.current = weather.current
                self.daily = weather.daily
            }
        }
    }
}
