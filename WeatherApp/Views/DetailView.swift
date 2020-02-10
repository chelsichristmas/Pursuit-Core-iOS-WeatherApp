//
//  DetailView.swift
//  WeatherApp
//
//  Created by Chelsi Christmas on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class DetailView: UIView {

    public lazy var forecastLabel: UILabel = {
       let label = UILabel()
        label.text = "Weather Forecast for New York"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    
    public lazy var imageView: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
     private func commonInit() {
        setupForecastLabel()
        setupImageView()
    }
    
    private func setupForecastLabel() {
    
        addSubview(forecastLabel)
        forecastLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forecastLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            forecastLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            forecastLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20)
        ])
    }
    
    private func setupImageView() {
        addSubview(imageView)
        forecastLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        forecastLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
        forecastLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

}
