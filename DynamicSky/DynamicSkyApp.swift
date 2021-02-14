import SwiftUI
import Firebase

@main
struct CyanSkyApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        
        WindowGroup {
            
            let weatherService = WeatherFromUserLocationService()
            let viewModel = WeatherViewModel(weatherService: weatherService)
            HomeView(viewModel: viewModel , selectedIndex: 0)
        }
    }
}
