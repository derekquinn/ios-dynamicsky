import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    @State var selectedIndex: Int
    
    var body: some View {
        NavigationView{
            TabView(selection: $selectedIndex) {
                
                CurrentLocalWeatherView(viewModel: viewModel)
                    .onTapGesture {
                        selectedIndex = 0
                        
                    }
                    .tabItem{
                        Text("Current")
                        Image(systemName: "location.north")
                        
                    }.tag(0)
                
                LocalWeatherForecastView()
                    .onTapGesture {
                        selectedIndex = 1
                        
                    }
                    .tabItem{
                        Text("Forecast")
                        Image(systemName: "calendar")
                        
                    }.tag(1)
            }
            
            .navigationBarItems(leading: Button(action: { }, label: {
                Image(systemName:"person")
            }))
            .navigationBarTitle("Username")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//}
////
////struct WeatherView_Previews: PreviewProvider {
////    static var previews: some View {
////        HomeView(viewModel: WeatherViewModel(weatherService: OpenSkyService()))
////    }
////}
