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
        }
        
        
        
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
