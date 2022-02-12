import SwiftUI

struct HomeView: View {

    @State var selectedIndex: Int = 0

    var body: some View {
        NavigationView {
            TabView(selection: $selectedIndex) {
                CurrentConditionsView()
                    .onTapGesture {
                        selectedIndex = 0
                    }
                    .tabItem {
                        Text(UIConstantsEN.tabItemCurrent)
                        Image(systemName: "location.north")
                    }.tag(0)
                DailyForecastView()
                    .onTapGesture {
                        selectedIndex = 1
                    }
                    .tabItem {
                        Text(UIConstantsEN.tabItemForecast)
                        Image(systemName: "calendar")
                    }.tag(1)
                SearchView()
                    .onTapGesture {
                        selectedIndex = 2
                    }
                    .tabItem {
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
