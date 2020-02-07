//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Chelsi Christmas on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct WeatherInfo: Codable {
    let timezone: String?
    let daily: WeekForecast
}

struct WeekForecast: Codable {
    let data: [Details]
}

struct Details: Codable {
    let summary: String
    let icon: String
    let time: Double
    let precipType: String?
    let temperatureHigh: Double
    let temperatureLow: Double
    let dewPoint: Double
    let humidity: Double
    let windGust: Double
}
