import Foundation

class DailyForecastViewModel: ObservableObject {

    @Published var weather: OpenWeatherResponse?

    init() {
        self.refreshDailyForecast()
    }

    private func refreshDailyForecast() {
        if let coordinates = UserLocationService.coordinates {
            OpenWeatherService.request(.forecastWithCoordinates(coordinates: coordinates)) { response in
                DispatchQueue.main.async {
                    self.weather = response
                }
            }
        }
    }

}
