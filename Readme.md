# DynamicSky iOS Application 0.0.3 (SwiftUI)
_DynamicSky is a simple and fast weather application for iOS versions 14 and above._

## Features 
- Current weather view with local temperature and feels like temperature. 
- Five day forecast with dynamic icons and hourly temperature per day
- Automatic user location retrieval (with user permission)
- Search by Zip Code for current weather conditions including temperature and feels like temperature.

## Dependencies 
- Firebase Crashlytics *v7.6.0* [(documentation)](https://firebase.google.com/docs/crashlytics) & [(repository)](https://github.com/firebase/firebase-ios-sdk/blob/master/SwiftPackageManager.md)
- Kingfisher *v6.1.0* [(repository)](https://github.com/onevcat/Kingfisher)
- *Dependencies are being managed using [Swift Package Manager](https://swift.org/package-manager/)*

## Open Weather Map API
- The /onecall endpoint from Open Weather Map API is used to fetch data for temperatures, dates and icons displayed in the UI. 
- [Documentation for /onecall endpoint](https://openweathermap.org/api/one-call-api)
- Codable protocol is utilized to parse & decode the API response in `OpenWeatherResponseModel.swift` & `WeatherService.swift`. 
- More on the Codable protocol from [Apple Documentation](https://developer.apple.com/documentation/swift/codable) 

## API Security
- The Open Weather Map Application ID is required to make a call.
- In order to run Dynamic Sky locally, developers must add a `Secrets.swift` file to the project and declare the application ID as shown below. 
- An Application ID can be obtained for free at[ this link with just an e-mail address](https://www.openweathermap.org/appid.). 

```swift 
struct Secrets {
    static let openWeatherAppId: String = "YOUR_APPLICATION_ID"
}
```

## Architecture
- Model View ViewModel pattern is implemented in the codebase, because it allows us to easily update dynamic values such as weather icons & temperature values. An excellent write up on best practices with MVVM in SwiftUI can be found on [Nalexn's GitHub Page](https://nalexn.github.io/clean-architecture-swiftui/). However, the limitations of SwiftUI are probably more important to review, see more from Alina Zaitseva at [SteelKiwi.com](https://steelkiwi.com/blog/swiftui-vs-uikit/). 

> - It supports only iOS 13+ and Xcode 11+. By switching to them, you abandon users of older versions of iOS, which is a radical move devoid of concern for the user. But since Apple annually updates its list of supported iOS versions, I think SwiftUI will be used more over the next two years as users install the latest iOS version.
> - It’s still very young, so there isn’t much data on Stack Overflow. This means that you can’t get much help resolving complicated issues.
> - It doesn’t allow you to examine the view hierarchy in Xcode Previews.

### More on Kingfisher
- Kingfisher is being used in DynamicSky to load and cache weather icons, which have their corresponding Open Weather URL stored in `viewModel.daily[index].weather[0].icon` for example. 
> "Kingfisher is a powerful, pure-Swift library for downloading and caching images from the web. It provides you a chance to use a pure-Swift way to work with remote images," from [onevcat](https://github.com/onevcat/Kingfisher).

### More on Firebase 
- Dynamic Sky currently uses FirebaseCrashlytics to log crashes with `CLLocationManger`& `URLSession`. The implementation is not mature as of v0.0.2 but has been successfully tested on several _sad paths._ 
- The Firebase repository (linked above) has useful information about how to install & update using Swift Package Manger.

