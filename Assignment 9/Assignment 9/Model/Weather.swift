//
//  Weather.swift
//  Assignment 9
//
//  Created by Garrett Li on 7/20/25.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Main
    let weather: [Weather]
    let name: String
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
}

struct Weather: Decodable {
    let description: String
    let icon: String
}


