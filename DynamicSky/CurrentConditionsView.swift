import SwiftUI

struct CurrentConditionsView: View {

    @ObservedObject var viewModel = CurrentConditionsViewModel()

    var body: some View {
        VStack {
            if let temp = viewModel.currentConditions?.searchResults?.temp,
               let feelsLike = viewModel.currentConditions?.searchResults?.feelsLike {
                Text("\(Int(temp))ºF")
                    .font(.system(size: 70))
                    .bold()
                Text("Feels Like \(Int(feelsLike))ºF")
                    .font(.system(size: 25))
                    .foregroundColor(.gray)
            } else {
                    LoadingView()
            }
        }
    }

}
