//  Created by Sergey Koriukin on 17/06/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.

import SwiftUI

struct CurrentWeatherRow: View {
  private let viewModel: CurrentWeatherRowViewModel
  
  init(viewModel: CurrentWeatherRowViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      MapView(coordinate: viewModel.coordinate)
        .cornerRadius(25)
        .frame(height: 300)
        .disabled(true)
      
      VStack(alignment: .leading) {
        HStack {
          Text("☀️ Temperature:")
          Text("\(viewModel.temperature)°")
            .foregroundColor(.gray)
        }
        
        HStack {
          Text("📈 Max temperature:")
          Text("\(viewModel.maxTemperature)°")
            .foregroundColor(.gray)
        }
        
        HStack {
          Text("📉 Min temperature:")
          Text("\(viewModel.minTemperature)°")
            .foregroundColor(.gray)
        }
        
        HStack {
          Text("💧 Humidity:")
          Text(viewModel.humidity)
            .foregroundColor(.gray)
        }
      }
    }
  }
}
