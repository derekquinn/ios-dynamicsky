import SwiftUI
import Firebase

@main
struct DynamicSkyApp: App {

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
