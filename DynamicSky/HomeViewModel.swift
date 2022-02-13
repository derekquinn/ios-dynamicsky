import Combine

final class HomeViewModel: ObservableObject {
    @Published var selectedTabIndex = 0

    init() {}
}
