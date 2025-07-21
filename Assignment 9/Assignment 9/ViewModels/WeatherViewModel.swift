//
//  WeatherViewModel.swift
//  Assignment 9
//
//  Created by Garrett Li on 7/20/25.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weatherList: [WeatherResponse] = []

    private let apiKey = "220bf0fe7c97553ff2f8d49811ddabdd" 
    private let cities = ["New York", "London", "Paris", "Tokyo", "Sydney"]

    func fetchWeatherData() {
        weatherList = []

        for city in cities {
            let cityQuery = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
            let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityQuery)&units=metric&appid=\(apiKey)"

            guard let url = URL(string: urlString) else { continue }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error fetching weather for \(city): \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("No data returned for \(city)")
                    return
                }

                do {
                    let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.weatherList.append(weather)
                    }
                } catch {
                    print("Decode error for \(city): \(error)")
                    if let json = String(data: data, encoding: .utf8) {
                        print("Raw data: \(json)")
                    }
                }
            }.resume()
        }
    }
}
