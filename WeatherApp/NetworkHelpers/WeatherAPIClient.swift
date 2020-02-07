//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Chelsi Christmas on 2/3/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper

struct WeatherAPIClient {
    
    static func fetchWeatherInfo (latitude: Double, longitude: Double, completion: @escaping (Result<[Details], AppError>) ->()) {

        let APIKey = "f67b176f9f4f6c0c06379995ba882d8e"
        let latitude = latitude
        let longitude = longitude


        let weatherEndpointURL = "https://api.darksky.net/forecast/\(APIKey)/\(latitude),\(longitude)"


        guard let url = URL(string: weatherEndpointURL) else {
            completion(.failure(.badURL(weatherEndpointURL)))
            return
            }

        let request = URLRequest(url: url)

        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure (let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode(WeatherInfo.self, from: data)
                    completion(.success(searchResults.daily.data))

                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }

    }
}
