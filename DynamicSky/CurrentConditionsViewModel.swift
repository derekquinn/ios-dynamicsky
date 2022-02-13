import Foundation

public class CurrentConditionsViewModel: ObservableObject {

    @Published var currentConditions: OpenWeatherSearchResponse?

    init(){
        self.refreshCurrentConditions()
    }

    private func refreshCurrentConditions() {
        if let coordinates = UserLocationService.coordinates {
            OpenWeatherService.request(.currentWeatherWithCoordinates(coordinates: coordinates)) { response in
                DispatchQueue.main.async {
                    self.currentConditions = response
                }
            }
        }
    }

}
