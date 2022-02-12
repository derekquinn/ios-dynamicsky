import SwiftUI

struct LoadingView: View {

    var body: some View {
        VStack{
            Text(UIConstantsEN.loadingView)
                .font(.caption)
                .italic()
            Text("📡")
                .font(.title)
        }
    }

}
