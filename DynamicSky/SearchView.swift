import SwiftUI

struct SearchView: View {
    @State var userEnteredZipCode: String = ""
    @ObservedObject var viewModel: WeatherViewModel
    @State var isZipCodeValid: Bool = true
    @State var isMessageNeeded: Bool = true
    
    var body: some View {
        VStack{
            HStack{
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
                            isMessageNeeded.toggle()
                            viewModel.retrieveSearchResults(zipCode: userEnteredZipCode)
                        }
                    }
            }
            
            if isMessageNeeded {
                Text("Tap the 🔎 to Search")
                    .padding(.top, 10)
                    .font(.caption)
            }
            
            Spacer()
            
            if !isZipCodeValid {
                VStack{
                    Text("❌")
                        .font(.caption)
                    Text("~*OOPSIE ~*")
                    Text("That's not a Zip Code")
                }.animation(.easeInOut, value: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                
            }
            
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
