//
//  PhotoInfo.swift
//  WeatherApp
//
//  Created by Chelsi Christmas on 2/10/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct PhotoInfo: Codable {
    let hits: [PhotoDetails]
}

struct PhotoDetails: Codable {
    let largeImageURL: String
}
