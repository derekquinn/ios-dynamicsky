import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: CurrentConditionsViewModel
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
                DailyForecastView()
                    .onTapGesture {
                        selectedIndex = 1
                    }
                    .tabItem{
                        Text(UIConstantsEN.tabItemForecast)
                        Image(systemName: "calendar")
                    }.tag(1)
                SearchView(userEnteredZipCode: "")
                    .onTapGesture {
                        selectedIndex = 2

                    }
                    .tabItem{
                        Text(UIConstantsEN.tabItemForecast)
                        Image(systemName: "magnifyingglass")
                    }.tag(2)
            }.colorInvert()
            .navigationBarTitle(UIConstantsEN.navBarTitle[selectedIndex])
            .navigationBarTitleDisplayMode(.large)
            .colorInvert()
        }
    }
}