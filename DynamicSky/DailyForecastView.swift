import SwiftUI
import Kingfisher

struct DailyForecastView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        
        VStack{
            if viewModel.daily.count > 0 {
                ForEach(OpenWeatherConstants.numberOfDailyForecasts.indices, id: \.self) { index in
                    HStack{
                        Text("\(DateHelper.convertEpochToDay(epoch: viewModel.daily[index].dt))")
                            .padding(.leading)
                            .padding(.trailing,20)
                            .font(.system(size: 20))
                        Spacer()
                        VStack{
                            Text(UIConstantsEN.dailyForecastTimes[0]).font(.footnote).padding(.bottom,2)
                            Text("\(Int(viewModel.daily[index].temp.morn))")
                        }.padding(.trailing, 20)
                        Spacer()
                        VStack{
                            Text(UIConstantsEN.dailyForecastTimes[1]).font(.footnote).padding(.bottom,2)
                            Text("\(Int(viewModel.daily[index].temp.day))")
                        }.padding(.trailing, 20)
                        Spacer()
                        VStack{
                            Text(UIConstantsEN.dailyForecastTimes[2]).font(.footnote).padding(.bottom,2)
                            Text("\(Int(viewModel.daily[index].temp.eve))")
                        }.padding(.trailing, 20)
                        Spacer()
                        let imageUrl = URL(string: "http://openweathermap.org/img/wn/\(viewModel.daily[index].weather[0].icon)@2x.png")
                        KFImage(imageUrl)
                    }
                }
                
            } else {
                LoadingView()
            }
        }
    }
}
