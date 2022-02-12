import SwiftUI

struct CurrentConditionsView: View {

    @ObservedObject var viewModel = CurrentConditionsViewModel()

    var body: some View {
        VStack {
            if let currentWeather = viewModel.current,
               let date = viewModel.current?.epochDate,
               let temp = currentWeather.temp,
               let feelsLike = currentWeather.tempFeelsLike {
                Text(DateHelper.convertEpochToFullDate(epoch: date))
                Text("\(Int(temp))ºF")
                    .font(.system(size: 70))
                    .bold()
                Text("\(UIConstantsEN.currentConditionsFeelsLike) \(Int(feelsLike))ºF")
                    .font(.system(size: 25))
                    .foregroundColor(.gray)
            } else {
                    LoadingView()
            }
        }
    }

}
