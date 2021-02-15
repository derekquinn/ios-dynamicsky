import SwiftUI

struct SearchView: View {
    @State var userEnteredZipCode: String = ""
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack{
            HStack{
                TextField("Enter a Zip Code", text: $userEnteredZipCode)
                    .padding()
                Image(systemName: "magnifyingglass").onTapGesture {
                    print("ZIP = \(userEnteredZipCode)")
                    viewModel.retrieveSearchResults(zipCode: userEnteredZipCode)
                }
            }
            Spacer()
            
            if viewModel.openWeatherSearchResponse.name != "" {
                
                Text(viewModel.openWeatherSearchResponse.name)
                Text("\(Int(viewModel.openWeatherSearchResponse.searchResults.temp))ºF")
                    .font(.system(size: 70))
                    .bold()
                Text("\(UIConstantsEN.currentConditionsFeelsLike)  \(Int(viewModel.openWeatherSearchResponse.searchResults.feelsLike))ºF")
                    .font(.system(size: 25))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
