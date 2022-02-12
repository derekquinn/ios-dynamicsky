import SwiftUI

struct CurrentConditionsView: View {
    @ObservedObject var viewModel = CurrentConditionsViewModel()

    var body: some View {
        VStack {
            if let currentWeather = viewModel.current {
                Text(DateHelper.convertEpochToFullDate(epoch: currentWeather.epochDate))
                Text("\(Int(currentWeather.temp))ºF")
                    .font(.system(size: 70))
                    .bold()
                Text("\(UIConstantsEN.currentConditionsFeelsLike)  \(Int(currentWeather.tempFeelsLike))ºF")
                    .font(.system(size: 25))
                    .foregroundColor(.gray)
            } else {
                    LoadingView()
            }
        }
    }
}
