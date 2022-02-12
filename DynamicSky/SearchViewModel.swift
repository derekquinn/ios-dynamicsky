import Foundation

final class SearchViewModel: ObservableObject {
    @Published var openWeatherSearchResponse: OpenWeatherSearchResponse?

    init() {}

    public func retrieveSearchResults(zipCode: String){
        DispatchQueue.main.async{
            WeatherFromZipSearchService.retrieveSearchResultsFromUserEnteredZip(zipCode: zipCode) { results in
                self.openWeatherSearchResponse = results
            }
        }
    }
}
