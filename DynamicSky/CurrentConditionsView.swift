import SwiftUI

struct CurrentConditionsView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            
            if viewModel.current.temp != 0 {
                Text(DateHelper.convertEpochToFullDate(epoch: viewModel.current.epochDate))
                Text("\(Int(viewModel.current.temp))ºF")
                    .font(.system(size: 70))
                    .bold()
                Text("\(UIConstantsEN.currentConditionsFeelsLike)  \(Int(viewModel.current.tempFeelsLike))ºF")
                    .font(.system(size: 25))
                    .foregroundColor(.gray)
            } else {
                VStack{
                    LoadingView()
                }
            }
        }.onAppear(perform: { viewModel.refreshWeatherData()} )
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentConditionsView(viewModel: WeatherViewModel(weatherService: WeatherFromUserLocationService()))
    }
}
