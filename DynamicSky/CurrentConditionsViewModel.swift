import Foundation

public class CurrentConditionsViewModel: ObservableObject {

    @Published var current = Current()
    private let weatherService =  WeatherFromUserLocationService()

    init(){
        self.refreshCurrentConditions()
    }

    private func refreshCurrentConditions(){
        weatherService.retrieveUserLocation { weather in
            DispatchQueue.main.async {
                self.current = weather.current
            }
        }
    }

}
