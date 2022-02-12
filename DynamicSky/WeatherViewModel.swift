import Foundation

public class WeatherViewModel: ObservableObject {
    
    @Published var cityName: String = ""
    @Published var temperature: String = ""
    @Published var weatherDescription: String = ""
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService){
        self.weatherService = weatherService
    }
    
    public func refresh(){
        weatherService.loadWeatherData { weather in
            DispatchQueue.main.async {
                self.cityName = ""
                self.temperature = "\(weather.current.temp)ºF"
                self.weatherDescription = ""
            }
        }
    }
}
