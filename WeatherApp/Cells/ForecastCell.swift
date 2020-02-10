//
//  forecastCell.swift
//  WeatherApp
//
//  Created by Chelsi Christmas on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class ForecastCell: UICollectionViewCell {
    
    var weatherDetails = [Details]()
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
//    var weatherInfoTitle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .yellow
        
    }
    
    
    public func configureCell(weatherInfo: Details?) {
        forecastImage.image = UIImage(named: weatherInfo!.icon)
        highTempLabel.text = "High: \(weatherInfo!.temperatureHigh) F"
        lowTempLabel.text = "Low: \(weatherInfo!.temperatureLow) F"
        
    }
}
