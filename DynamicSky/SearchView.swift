import SwiftUI

struct SearchView: View {

    @State var userEnteredZipCode: String = ""
    @ObservedObject var viewModel = SearchViewModel()
    @State var isZipCodeValid: Bool = true

    var body: some View {
        VStack {
            HStack {
                TextField("Enter a Zip Code", text: $userEnteredZipCode)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(18)
                
                Image(systemName: "magnifyingglass")
                    .padding(.trailing, 10)
                    .onTapGesture {
                        print("ZIP = \(userEnteredZipCode)")
                        isZipCodeValid = ValidationHelper.isZipCodeValid(zipCode: userEnteredZipCode)
                        if isZipCodeValid {
                            viewModel.retrieveSearchResults(zipCode: userEnteredZipCode)
                        }
                    }
            }

            Spacer()

            if !viewModel.openWeatherSearchResponse.name.isEmpty,
               let currentWeather = viewModel.openWeatherSearchResponse {
                Text(currentWeather.name)
                Text("\(Int(currentWeather.searchResults.temp))ºF")
                    .font(.system(size: 70))
                    .bold()
                Text("\(UIConstantsEN.currentConditionsFeelsLike) \(Int(currentWeather.searchResults.feelsLike))ºF")
                    .font(.system(size: 25))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }

}
