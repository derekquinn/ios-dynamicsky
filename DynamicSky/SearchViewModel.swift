import Foundation

final class SearchViewModel: ObservableObject {

    @Published var openWeatherSearchResponse: OpenWeatherSearchResponse?

    public func retrieveSearchResults(zipCode: String) {
        DispatchQueue.main.async{
            OpenWeatherService.request(.currentWeatherWithZip(zipCode: zipCode)) { result in
                DispatchQueue.main.async {
                    self.openWeatherSearchResponse = result
                }
            }
        }
    }

}
