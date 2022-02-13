import SwiftUI

struct HomeView: View {

    @State var selectedIndex: Int = 0
    private var userLocationService = UserLocationService()

    var body: some View {
        NavigationView {
            TabView(selection: $selectedIndex) {
                CurrentConditionsView()
                    .onTapGesture {
                        selectedIndex = 0
                    }
                    .tabItem {
                        Text("Current")
                        Image(systemName: "location.north")
                    }.tag(0)
                DailyForecastView()
                    .onTapGesture {
                        selectedIndex = 1
                    }
                    .tabItem {
                        Text("Forecast")
                        Image(systemName: "calendar")
                    }.tag(1)
                SearchView()
                    .navigationTitle("Search")
                    .onTapGesture {
                        selectedIndex = 2
                    }
                    .tabItem {
                        Text("Search")
                        Image(systemName: "magnifyingglass")
                    }.tag(2)
            }.colorInvert()
            .navigationBarTitle(navBarTitle)
            .navigationBarTitleDisplayMode(.large)
            .colorInvert()
        }
    }
}

fileprivate extension HomeView {
    private var navBarTitle: String {
        switch selectedIndex {
        case 0:
            return "Current Conditions"
        case 1:
            return "Forecast"
        case 2:
            return "Search"
        default:
            return ""
        }
    }
}

