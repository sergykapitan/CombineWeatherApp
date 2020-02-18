//  Created by Sergey Koriukin on 17/06/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.

import Foundation

enum WeatherError: Error {
  case parsing(description: String)
  case network(description: String)
}
