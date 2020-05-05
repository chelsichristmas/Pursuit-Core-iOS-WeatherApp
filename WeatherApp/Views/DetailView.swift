//
//  DetailView.swift
//  WeatherApp
//
//  Created by Chelsi Christmas on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    public lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .black
        return button
       
    }()

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
    
    public lazy var descriptionLabel: UILabel = {
    let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    //high, low, sunrise, sunset, windspeed and precipitation
    
    public lazy var temperatureHighLabel: UILabel = {
        let label = UILabel()
               return label
    }()
    
    public lazy var temperatureLowLabel: UILabel = {
        let label = UILabel()
               return label
    }()
    
    public lazy var sunriseLabel: UILabel = {
           let label = UILabel()
                  return label
       }()
    
    public lazy var humidityLabel: UILabel = {
           let label = UILabel()
                  return label
       }()
    public lazy var windspeedLabel: UILabel = {
           let label = UILabel()
                  return label
       }()
    
    public lazy var precipitationLabel: UILabel = {
           let label = UILabel()
                  return label
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
        setupFavoriteButton()
        setupForecastLabel()
        setupImageView()
        setupDescriptionLabel()
        setupTemperatureHighLabel()
        setupTemperatureLowLabel()
        setupSunsetLabel()
        setupWindspeedLabel()
        setupPrecipitationLabel()
    }
    
    private func setupFavoriteButton() {
        addSubview(favoriteButton)
              favoriteButton.translatesAutoresizingMaskIntoConstraints = false
              NSLayoutConstraint.activate([
                  favoriteButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
                  favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                  favoriteButton.heightAnchor.constraint(equalToConstant: 20),
                  favoriteButton.widthAnchor.constraint(equalToConstant: 20)
              ])
    }
    
    private func setupForecastLabel() {
    
        addSubview(forecastLabel)
        forecastLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forecastLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            forecastLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            forecastLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20)
        ])
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        imageView.topAnchor.constraint(equalTo: forecastLabel.bottomAnchor, constant: 20),
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.40),
        imageView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    private func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    // high, low, sunrise, sunset, windspeed and precipitation
    private func setupTemperatureHighLabel() {
        addSubview(temperatureHighLabel)
        temperatureHighLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperatureHighLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            temperatureHighLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            temperatureHighLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func setupTemperatureLowLabel() {
        addSubview(temperatureLowLabel)
        temperatureLowLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperatureLowLabel.topAnchor.constraint(equalTo: temperatureHighLabel.bottomAnchor, constant: 8),
            temperatureLowLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            temperatureLowLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func setupSunsetLabel() {
        addSubview(humidityLabel)
               humidityLabel.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   humidityLabel.topAnchor.constraint(equalTo: temperatureLowLabel.bottomAnchor, constant: 8),
                   humidityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                   humidityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
               ])
    }
    
    private func setupWindspeedLabel() {
        addSubview(windspeedLabel)
        windspeedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            windspeedLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 8),
            windspeedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            windspeedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func setupPrecipitationLabel() {
        addSubview(precipitationLabel)
        precipitationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            precipitationLabel.topAnchor.constraint(equalTo: windspeedLabel.bottomAnchor, constant: 8),
            precipitationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            precipitationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    
    

}
