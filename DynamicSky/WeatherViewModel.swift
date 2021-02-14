import Foundation

public class WeatherViewModel: ObservableObject {
    
    @Published var currentLocalTemperature: String = ""
    @Published var daily = [Daily]()
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService){
        self.weatherService = weatherService
    }
    
    public func refresh(){
        weatherService.loadWeatherData { weather in
            DispatchQueue.main.async {
                self.currentLocalTemperature = "\(weather.current.temp)ºF"
                self.daily = weather.daily
            }
        }
    }
}
