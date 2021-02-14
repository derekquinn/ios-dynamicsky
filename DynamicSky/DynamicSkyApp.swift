import SwiftUI

@main
struct CyanSkyApp: App {
    var body: some Scene {
        WindowGroup {
            let weatherService = WeatherService()
            let viewModel = WeatherViewModel(weatherService: weatherService)
            HomeView(viewModel: viewModel , selectedIndex: 0)
        }
    }
}
