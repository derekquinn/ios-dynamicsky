import SwiftUI
struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    var userLocationService = UserLocationService()

    var body: some View {
        NavigationView {
            TabView(selection: $viewModel.selectedTabIndex) {
                CurrentConditionsView()
                    .tabItem {
                        Text("Current")
                        Image(systemName: "location.north")
                    }.tag(0)
                DailyForecastView()
                    .tabItem {
                        Text("Forecast")
                        Image(systemName: "calendar")
                    }.tag(1)
                SearchView()
                    .tabItem {
                        Text("Search")
                        Image(systemName: "magnifyingglass")
                    }.tag(2)
            }.navigationBarTitle("Dynamic Sky")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
