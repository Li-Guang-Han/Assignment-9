//
//  ContentView.swift
//  Assignment 9
//
//  Created by Garrett Li on 7/20/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.weatherList, id: \.name) { weather in
                NavigationLink(destination: WeatherDetailView(weather: weather)) {
                    HStack {
                        Text(weather.name)
                        Spacer()
                        Text("\(Int(weather.main.temp))°C")
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("City Weather")
            .onAppear {
                viewModel.fetchWeatherData()
            }
        }
    }
}

#Preview {
    ContentView()
}

