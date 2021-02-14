import SwiftUI

@main
struct CyanSkyApp: App {
    var body: some Scene {
        WindowGroup {
            var weatherService = WeatherService()
            var viewModel = WeatherViewModel(weatherService: weatherService)
            HomeView(viewModel: viewModel , selectedIndex: 0)
        }
    }
}
