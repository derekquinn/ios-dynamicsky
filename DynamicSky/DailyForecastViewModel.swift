import Foundation

class DailyForecastViewModel: ObservableObject {

    @Published var weather: OpenWeatherResponse?

    init() {
        self.refreshDailyForecast()
    }

    private func refreshDailyForecast() {
        if let coordinates = UserLocationService.coordinates {
            DispatchQueue.main.async {
                OpenWeatherService.request(.forecastWithCoordinates(coordinates: coordinates)) { response in
                    self.weather = response
                }
            }
        }
    }

}
