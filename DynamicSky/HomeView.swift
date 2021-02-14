import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    @State var selectedIndex: Int
    
    var body: some View {
        NavigationView{
            TabView(selection: $selectedIndex) {
                
                CurrentConditionsView(viewModel: viewModel)
                    .onTapGesture {
                        selectedIndex = 0
                    }
                    .tabItem{
                        Text(UIConstantsEN.tabItemCurrent)
                        Image(systemName: "location.north")
                        
                    }.tag(0)
                
                DailyForecastView(viewModel: viewModel)
                    .onTapGesture {
                        selectedIndex = 1
                        
                    }
                    .tabItem{
                        Text(UIConstantsEN.tabItemForecast)
                        Image(systemName: "calendar")
                    }.tag(1)
            }.colorInvert()
            // commented navigationBar button triggers fatalError() for testing sad path
            //            .navigationBarItems(leading: Button(action: { fatalError()}, label: {
            //                Image(systemName:"exclamationmark.triangle").foregroundColor(.red)
            //            }))
            .navigationBarTitle(UIConstantsEN.navBarTitle[selectedIndex])
            .navigationBarTitleDisplayMode(.large)
            .colorInvert()
        }
    }
}
