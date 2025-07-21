//
//  WeatherDetailView.swift
//  Assignment 9
//
//  Created by Garrett Li on 7/20/25.
//

import SwiftUI

struct WeatherDetailView: View {
    let weather: WeatherResponse

    var body: some View {
        VStack(spacing: 20) {
            Text(weather.name)
                .font(.largeTitle)
                .bold()

            if let icon = weather.weather.first?.icon,
               let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                } placeholder: {
                    ProgressView()
                }
            }

            Text("Temperature: \(Int(weather.main.temp))°C")
            Text("Humidity: \(weather.main.humidity)%")
            Text("Condition: \(weather.weather.first?.description.capitalized ?? "N/A")")
        }
        .padding()
        .navigationTitle("Details")
    }
}

#Preview {
    let sampleWeather = WeatherResponse(
        main: Main(temp: 23.5, humidity: 65),
        weather: [Weather(description: "clear sky", icon: "01d")],
        name: "Sample City"
    )
    return WeatherDetailView(weather: sampleWeather)
}
