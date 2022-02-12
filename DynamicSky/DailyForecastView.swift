import SwiftUI
import Kingfisher

struct DailyForecastView: View {

    @ObservedObject var viewModel = DailyForecastViewModel()

    var body: some View {

        List {
            if let dailyForecast = viewModel.daily {
                ForEach(dailyForecast) { forecast in
                    HStack(alignment: .center) {
                        Text("\(Int(forecast.temp.morn))")
                            .padding(20)
                        Text("\(Int(forecast.temp.day))")
                            .padding(20)
                        Text("\(Int(forecast.temp.eve))")
                            .padding(20)
                        let imageUrl = URL(string: "http://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png")
                        KFImage(imageUrl)
                    }
                }
            }
        }
    }

}
