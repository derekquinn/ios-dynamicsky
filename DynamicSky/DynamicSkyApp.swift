import SwiftUI
import Firebase

@main
struct CyanSkyApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            let viewModel = CurrentConditionsViewModel()
            HomeView(viewModel: viewModel , selectedIndex: 0)
        }
    }
}
