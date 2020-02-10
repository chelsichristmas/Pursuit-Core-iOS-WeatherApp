//
//  PixaBayAPIClient.swift
//  WeatherApp
//
//  Created by Chelsi Christmas on 2/8/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper

struct PixabayAPIClient {
    static func fetchPhotos (searchQuery: String, completion: @escaping (Result<[PhotoDetails], AppError>) ->()) {

        let APIKey = "15003239-b376045a59a74ecfff7bb35cd"
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)



        let pixabayEndpointURL = "https://pixabay.com/api/?key=\(APIKey)&q=\(searchQuery ?? "blue")&image_type=photo"


        guard let url = URL(string: pixabayEndpointURL) else {
            completion(.failure(.badURL(pixabayEndpointURL)))
            return
            }

        let request = URLRequest(url: url)

        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure (let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode(PhotoInfo.self, from: data)
                    completion(.success(searchResults.hits))

                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }

    }
}
