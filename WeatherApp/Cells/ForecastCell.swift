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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .yellow
        
    }
    
    
    public func configureCell(weatherInfo: Details?) {
        
        highTempLabel.text = "\(weatherInfo!.temperatureHigh)"
        
    }
}
