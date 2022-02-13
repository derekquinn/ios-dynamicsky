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

            if let name = viewModel.openWeatherSearchResponse?.name,
               let temp = viewModel.openWeatherSearchResponse?.searchResults?.temp,
               let feelsLike = viewModel.openWeatherSearchResponse?.searchResults?.feelsLike {
                Text(name)
                Text("\(Int(temp))ºF")
                    .font(.system(size: 70))
                    .bold()
                Text("Feels Like \(Int(feelsLike))ºF")
                    .font(.system(size: 25))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }

}
