//
//  WeatherAppUnitTests.swift
//  WeatherAppUnitTests
//
//  Created by Frédéric Helfer on 23/02/23.
//

import Foundation
import XCTest

@testable import WeatherApp

final class WeatherAppUnitTests: XCTestCase {

    override class func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws {
        let json = """
        {
          "coord": {
            "lon": -122.0105,
            "lat": 37.321
          },
          "weather": [
            {
              "id": 801,
              "main": "Clouds",
              "description": "algumas nuvens",
              "icon": "02n"
            }
          ],
          "base": "stations",
          "main": {
            "temp": 2.45,
            "feels_like": -0.19,
            "temp_min": 0.76,
            "temp_max": 4.69,
            "pressure": 1010,
            "humidity": 86
          },
          "visibility": 10000,
          "wind": {
            "speed": 2.57,
            "deg": 130
          },
          "clouds": {
            "all": 20
          },
          "dt": 1677152677,
          "sys": {
            "type": 2,
            "id": 2009150,
            "country": "US",
            "sunrise": 1677163658,
            "sunset": 1677203732
          },
          "timezone": -28800,
          "id": 5341145,
          "name": "Cupertino",
          "cod": 200
        }
        """
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let data = json.data(using: .utf8)!
        let result = try! decoder.decode(CurrentWeather.self, from: data)
        
        XCTAssertEqual(result.weather.first?.id, 801)
        XCTAssertEqual(result.main?.temp, 2.45)
    }
}
