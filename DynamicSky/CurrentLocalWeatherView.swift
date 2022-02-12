import SwiftUI

struct CurrentLocalWeatherView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    
    var body: some View {
        VStack {
//            Text(viewModel.cityName)
//                .font(.largeTitle)
//                .padding()
            Text(viewModel.temperature)
                .font(.system(size: 70))
                .bold()
//            Text(viewModel.weatherIcon)
//                .font(.largeTitle)
//                .padding()
            Text(viewModel.weatherDescription)
        }.onAppear(perform: { viewModel.refresh()} )
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentLocalWeatherView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}
