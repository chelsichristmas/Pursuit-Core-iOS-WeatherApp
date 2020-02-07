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
        
        return label
    }()
    
    public lazy var imageView: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit() {
        
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
