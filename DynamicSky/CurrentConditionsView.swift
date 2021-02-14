import SwiftUI

struct CurrentConditionsView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            
            Text(viewModel.currentLocalTemperature)
                .font(.system(size: 70))
                .bold()
            
        }.onAppear(perform: { viewModel.refresh()} )
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentConditionsView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}
