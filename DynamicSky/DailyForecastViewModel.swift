import Foundation

class DailyForecastViewModel: ObservableObject {
    @Published var daily: [Daily]?
    private let weatherService =  WeatherFromUserLocationService()

    init() {
        self.refreshDailyForecast()
    }

    private func refreshDailyForecast(){
        weatherService.retrieveUserLocation { weather in
            DispatchQueue.main.async {
                self.daily = weather.daily
            }
        }
    }

}
