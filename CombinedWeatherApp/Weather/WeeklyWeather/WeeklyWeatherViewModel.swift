//  Created by Sergey Koriukin on 17/06/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.

import SwiftUI
import Combine


class WeeklyWeatherViewModel: ObservableObject, Identifiable {
 
  @Published var city: String = ""
  @Published var dataSource: [DailyWeatherRowViewModel] = []

  private let weatherFetcher: WeatherFetchable
  private var disposables = Set<AnyCancellable>()
  

  init(
    weatherFetcher: WeatherFetchable,
    scheduler: DispatchQueue = DispatchQueue(label: "WeatherViewModel")
  ) {
    self.weatherFetcher = weatherFetcher
    _ = $city
      .dropFirst(1)
      .debounce(for: .seconds(0.5), scheduler: scheduler)
      .sink(receiveValue: fetchWeather(forCity:))
  }

func fetchWeather(forCity city: String) {
  weatherFetcher.weeklyWeatherForecast(forCity: city)
    .map { response in
      // 2
      response.list.map(DailyWeatherRowViewModel.init)
    }

    // 3
    .map(Array.removeDuplicates)

    // 4
    .receive(on: DispatchQueue.main)

    // 5
    .sink(
      receiveCompletion: { [weak self] value in
        guard let self = self else { return }
        switch value {
        case .failure:
          // 6
          self.dataSource = []
        case .finished:
          break
        }
      },
      receiveValue: { [weak self] forecast in
        guard let self = self else { return }

        // 7
        self.dataSource = forecast
    })

    // 8
    .store(in: &disposables)
 }
}
//extension WeeklyWeatherViewModel {
//  var currentWeatherView: some View {
//    return WeeklyWeatherBuilder.makeCurrentWeatherView(
//      withCity: city,
//      weatherFetcher: weatherFetcher
//    )
//  }
//}
