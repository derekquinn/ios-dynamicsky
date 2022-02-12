import SwiftUI
import Kingfisher

struct DailyForecastView: View {

    @ObservedObject var viewModel = DailyForecastViewModel()

    var body: some View {
        VStack{
            if !viewModel.daily.isEmpty,
               let dailyForecast = viewModel.daily {
                ForEach(OpenWeatherConstants.numberOfDailyForecasts.indices, id: \.self) { index in
                    HStack{
                        Text("\(DateHelper.convertEpochToDay(epoch: dailyForecast[index].dt))")
                            .padding(.leading)
                            .padding(.trailing,12)
                            .font(.caption)
                        Spacer()
                        VStack{
                            Text(UIConstantsEN.dailyForecastTimes[0]).font(.footnote).padding(.bottom,2)
                            Text("\(Int(dailyForecast[index].temp.morn))")
                        }.padding(.trailing, 20)
                        Spacer()
                        VStack{
                            Text(UIConstantsEN.dailyForecastTimes[1]).font(.footnote).padding(.bottom,2)
                            Text("\(Int(dailyForecast[index].temp.day))")
                        }.padding(.trailing, 20)
                        Spacer()
                        VStack{
                            Text(UIConstantsEN.dailyForecastTimes[2]).font(.footnote).padding(.bottom,2)
                            Text("\(Int(dailyForecast[index].temp.eve))")
                        }.padding(.trailing, 20)
                        Spacer()
                        let imageUrl = URL(string: "http://openweathermap.org/img/wn/\(dailyForecast[index].weather[0].icon)@2x.png")
                        KFImage(imageUrl)
                    }
                }
            } else {
                LoadingView()
            }
        }
    }

}
